# =============================================================================
# Phase 2 — The AI Audit: Bank Account
#
# This script was "written by AI." It has exactly 5 mistakes:
#   - 2 syntax errors  (Ruby won't even run until these are fixed)
#   - 3 logic flaws    (Ruby runs but produces wrong results)
#
# Your job: find all 5, add a comment above each bug, then fix them.
# Use this format for your comments:
#   # BUG [n]: [what is wrong] → FIX: [what it should be]
# =============================================================================

class BankAccount
  attr_reader :balance, :owner

  def initialize(owner, initial_balance)
    @owner   = owner
    @balance = initial_balance
    @rate    = 0.05
  end

  def deposit(amount)
    if amount > 0
      #  3 Logic  @balance -= amount subtracts the deposit instead of adding it 
      @balance += amount
      puts "  New balance: $#{"%.2f" % @balance}"
    else
      puts "  Error: Deposit amount must be positive."
    end
  end

  def withdraw(amount)
    #  5 Logic  no  guard; balance can go negative 
    if @balance < amount
      puts "  Error: Insufficient funds. Balance: $#{"%.2f" % @balance}"
      return
    end
    @balance -= amount
    puts "  New balance: $#{"%.2f" % @balance}"
  end
  #  1 Syntax  missing its closing end

  def apply_interest
    #  4 Logic  @balance = @balance * @rate replaces balance with just the interest amount 
    @balance += @balance * @rate
    puts "  New balance: $#{"%.2f" % @balance}"
  end

  def display_info
    puts "Owner  : #{@owner}"
    #  2 Syntax  uses #( instead of #{  
    puts "Balance: $#{"%.2f" % @balance}"
  end
end

# --- Script entry point ---

account = BankAccount.new("Alice", 1000)

puts "=== Account Info ==="
account.display_info
puts

puts "Depositing $500..."
account.deposit(500)
puts

puts "Withdrawing $200..."
account.withdraw(200)
puts

puts "Applying 5% interest..."
account.apply_interest
puts

puts "Attempting to overdraw $2000..."
account.withdraw(2000)
