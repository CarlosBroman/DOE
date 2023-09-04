# Define the factor levels
insulin_levels = [0.5, 1.0, 2.0]
zinc_levels = [0.75, 1.125, 1.5]
iron_levels = [0.40, 1.0, 1.60]
selenium_levels = [0.5, 0.75, 1.0]

# Initialize an empty array to store the growth rate values
growth_rate_values = Float64[]

# Generate growth rate values based on the equation with interaction
for insulin in insulin_levels
    for zinc in zinc_levels
        for iron in iron_levels
            for selenium in selenium_levels
                # Calculate growth rate with interaction
                growth_rate = insulin * 0.152 + zinc * 0.092 + selenium * 0.031 - iron * 0.076 + insulin * selenium * 1 + zinc * iron * 0.7 + zinc * selenium * 0.55
                push!(growth_rate_values, growth_rate)
            end
        end
    end
end

print(growth_rate_values)