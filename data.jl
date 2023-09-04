using DataFrames

# Define factor levels
insulin_levels = [0.5, 1.0, 2.0]
zinc_levels = [0.75, 1.25, 1.5]
iron_levels = [0.40, 1.0, 1.60]
selenium_levels = [0.5, 0.75, 1.0]
codifier = ["Low", "Medium", "High"]

# Create a function to calculate growth rate based on factor levels
function calculate_growth_rate(insulin, zinc, selenium, iron)
    interaction = insulin * selenium * 2.0
    return insulin * 0.152 + zinc * 0.092 - iron * 0.076 + interaction
end

# Generate growth rate values based on factor levels
growth_rate_values = [
    calculate_growth_rate(insulin, zinc, selenium, iron)
    for insulin in insulin_levels
    for zinc in zinc_levels
    for selenium in selenium_levels
    for iron in iron_levels
]
print(growth_rate_values)
