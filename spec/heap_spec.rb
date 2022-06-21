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

  describe "#replace" do
    it "returns the highest value, excluding the new one" do
      heap.add(8)
      heap.add(100)
      heap.add(3)

      expect(heap.replace(123)).to eq(100)
    end

    it "sets up subsequent pops to return the highest values in order" do
      heap.add(8)
      heap.add(100)
      heap.add(3)
      heap.replace(5)

      expect(heap.pop).to eq(8)
      expect(heap.pop).to eq(5)
      expect(heap.pop).to eq(3)
    end
  end

  describe "performance" do
    it "adds and pops really fast" do
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

    it "replaces really fast too" do
      initial_random_numbers = (1..10000).to_a.select(&:even?).shuffle
      replacement_random_numbers = (1..10000).to_a.select(&:odd?).shuffle

      initial_random_numbers.each { |num| heap.add(num) }

      t1 = Time.now
      replacement_random_numbers.each { |num| heap.replace(num) }
      t2 = Time.now

      # 0.058s on pop + add
      # 0.036s on true replacement
      expect(t2 - t1).to be < 0.055
      expect(t2 - t1).to be < 0.040
    end
  end
end