# frozen_string_literal: true

# Murmur RPC client for Ruby
# (C) 2020- Roman Hargrave <roman@hargrave.info>
# Licensed under the GPL-3.0 - see LICENSE for more details

module MurmurRPC
  # An enumerable that depletes an internal queue
  # When the queue is not empty, {#each} will block
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

    # Prepend an element to the buffer
    #
    # @param [Object] elem Element to prepend
    def prepend(elem)
      @mutex.synchronize { @queue.prepend(elem) }
      @read_thread&.wakeup
    end

    # (see #prepend)
    def <<(elem)
      self.prepend(elem)
    end

    # (see Enumerable#each)
    def each
      raise 'This enumerator can only be read from a single thread' if @read_thread && @read_thread != Thread.current

      @read_thread = Thread.current
      loop do
        yield @mutex.synchronize { @queue.pop }
        Thread.stop if @queue.empty?
      end
      self
    end
  end
end
