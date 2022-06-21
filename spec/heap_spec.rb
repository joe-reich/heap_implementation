require 'pry'
require_relative '../heap'

describe Heap do
  let(:heap) { Heap.new }

  describe '#add' do
    it 'increases the length' do
      expect { heap.add(27) }.to change { heap.length }.by(1)
    end
  end

  describe '#pop' do
    it 'decreases the length' do
      heap.add(33)

      expect { heap.pop }.to change { heap.length }.by(-1)
    end

    it 'returns an item' do
      heap.add(2)

      expect(heap.pop).to eq(2)
    end

    it 'returns nil if there are no items' do
      expect(heap.pop).to be_nil
    end

    it 'returns the item with the highest value' do
      heap.add(3)
      heap.add(100)
      heap.add(8)

      expect(heap.pop).to eq(100)
    end
  end

  describe "performance" do
    it "runs really fast" do
      random_numbers = (1..10000).to_a.shuffle

      t1 = Time.now

      random_numbers.each do |num|
        heap.add(num)
      end
      10000.times { heap.pop }

      t2 = Time.now

      # 2.2s on naive version
      # 0.1s on heap implementation
      expect(t2 - t1).to be < 2.0
      expect(t2 - t1).to be < 0.2
    end
  end
end