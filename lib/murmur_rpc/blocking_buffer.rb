# frozen_string_literal: true

# Murmur RPC client for Ruby
# (C) 2020- Roman Hargrave <roman@hargrave.info>
# Licensed under the GPL-3.0 - see LICENSE for more details

module MurmurRPC
  # @private
  # An enumerable that depletes an internal queue
  # When the queue is empty, {#each} will block
  # until the queue is repopulated.
  #
  # Blocking behaviour is achieved by abuse of {Thread::current} {Thread::stop} and {Thread#wakeup}
  class BlockingBuffer
    include Enumerable

    # Create a BlockingBuffer
    #
    # @param [Array] elems Initial elements
    def initialize(elems = [])
      @queue = Array.new(elems)
      @mutex = Mutex.new
    end

    # Append an element to the queue and wake the consumer thread
    #
    # @param [Object] elem Element to prepend
    def append(elem)
      @mutex.synchronize { @queue << elem }
      @iter_thr&.wakeup
    end

    # (see #prepend)
    alias << append

    # Consume queue entries, head first
    def each
      raise 'This enumerator can only be read from a single thread' if @iter_thr && @iter_thr != Thread.current

      @iter_thr = Thread.current
      loop do
        yield @mutex.synchronize { @queue.shift }
        Thread.stop if @queue.empty?
      end
      self
    end
  end
end
