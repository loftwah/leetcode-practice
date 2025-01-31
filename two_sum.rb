# The Two Sum Problem: Finding Pairs That Add Up!
#
# Real World Example:
# Imagine you're building a feature for a shopping app where customers can find
# two items that fit exactly within their budget. If a customer has $50 to spend,
# this algorithm could quickly find two items that add up to exactly $50!

def two_sum(nums, target)
  # Think of this hash like a notebook where we write down
  # numbers we've seen before and where we saw them
  seen = {}
  
  # Look at each number one at a time
  nums.each_with_index do |num, i|
    # What number would we need to add to the current number
    # to reach our target? This is our "complement"
    complement = target - num
    
    # Have we seen this complement before?
    if seen.key?(complement)
      # Woohoo! We found a pair that works!
      return [seen[complement], i]
    end
    
    # If we haven't found a match, write down this number
    # and its position for later
    seen[num] = i
  end
  
  # If we get here, we couldn't find any pairs that work
  nil
end

puts "\n🎯 Two Sum: Finding Pairs That Add Up!"
puts "======================================"
puts "Let's see how this works with some examples..."

puts "\n🛍️  Real World Example: Shopping on a Budget"
puts "----------------------------------------"
prices = [25, 15, 10, 35, 20]
budget = 45
puts "You have $#{budget} to spend at a store with these prices: $#{prices.join(', ')}"
puts "\nInteresting fact: There are actually TWO pairs of items that add up to $#{budget}!"
puts "\nLet's find them manually:"
puts "\nPair 1 Walkthrough (what our code finds):"
puts "1. Looking at $#{prices[0]}:"
puts "   - We'd need another item costing $#{budget - prices[0]} to hit our budget"
puts "   - Haven't seen that price yet, let's keep looking"
puts "2. Looking at $#{prices[1]}:"
puts "   - We'd need another item costing $#{budget - prices[1]} to hit our budget"
puts "   - Haven't seen that price yet, let's keep looking"
puts "3. Looking at $#{prices[2]}:"
puts "   - We'd need another item costing $#{budget - prices[2]} to hit our budget"
puts "   - Haven't seen that price yet, let's keep looking"
puts "4. Looking at $#{prices[3]}:"
puts "   - We'd need another item costing $#{budget - prices[3]} to hit our budget"
puts "   - We saw $10 earlier! That works!"

puts "\nPair 2 (also exists but our code stops at first match):"
puts "- $25 + $20 = $45"
puts "\nWhy don't we find both pairs?"
puts "- Our code is designed to return the first valid pair it finds"
puts "- This makes it faster, but means we might miss other valid combinations"
puts "- If you needed ALL possible pairs, we'd need to modify the code!"

result = two_sum(prices, budget)
if result
  puts "\n💡 Found it! You can buy items costing $#{prices[result[0]]} and $#{prices[result[1]]}"
  puts "   These add up to exactly $#{budget}!"
end

puts "\n🔢 Example 1: Simple Numbers"
puts "-------------------------"
nums = [2, 7, 11, 15]
target = 9
puts "Numbers we have: #{nums}"
puts "Number we're trying to add up to: #{target}"
puts "\nThinking process:"
puts "1. Start with a blank notebook"
puts "2. See 2:"
puts "   - Need 7 to reach 9"
puts "   - Write down 2 in our notebook"
puts "3. See 7:"
puts "   - Need 2 to reach 9"
puts "   - Hey, we wrote down 2 earlier!"
result = two_sum(nums, target)
puts "\nAnswer: Use numbers at positions #{result.inspect}"
puts "Because #{nums[result[0]]} + #{nums[result[1]]} = #{target}"

puts "\n🎲 Example 2: Finding Numbers Later in the List"
puts "-------------------------------------------"
nums = [3, 2, 4]
target = 6
puts "Numbers we have: #{nums}"
puts "Number we're trying to add up to: #{target}"
puts "\nThinking process:"
puts "1. Start with a blank notebook"
puts "2. See 3:"
puts "   - Need 3 to reach 6"
puts "   - Write down 3 in our notebook"
puts "3. See 2:"
puts "   - Need 4 to reach 6"
puts "   - Write down 2 in our notebook"
puts "4. See 4:"
puts "   - Need 2 to reach 6"
puts "   - Hey, we wrote down 2 earlier!"
result = two_sum(nums, target)
puts "\nAnswer: Use numbers at positions #{result.inspect}"
puts "Because #{nums[result[0]]} + #{nums[result[1]]} = #{target}"

puts "\n❌ Example 3: When We Can't Find a Match"
puts "-------------------------------------"
nums = [1, 2, 3]
target = 10
puts "Numbers we have: #{nums}"
puts "Number we're trying to add up to: #{target}"
puts "\nThinking process:"
puts "1. Start with a blank notebook"
puts "2. Check each number, but never find two that add up to #{target}"
result = two_sum(nums, target)
puts "\nAnswer: #{result.inspect}"
puts "No two numbers add up to #{target} 🤷‍♂️"

puts "\n⚡ Why This Is Fast:"
puts "----------------"
puts "1. We only need to look at each number once"
puts "2. Our 'notebook' (hash map) lets us find numbers instantly"
puts "3. Much faster than checking every possible pair!"

puts "\n💡 Real World Applications:"
puts "----------------------"
puts "1. Shopping apps finding items that fit a budget"
puts "2. Financial apps finding matching transactions"
puts "3. Game matchmaking with players of complementary skill levels"
puts "4. Recipe apps finding ingredient pairs that match nutritional goals"

puts "\n🎯 Try It Yourself!"
puts "---------------"
puts "Think of this like a matching game where you're trying to find"
puts "two numbers that are perfect partners for reaching your target!"
