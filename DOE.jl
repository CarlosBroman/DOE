using DataFrames
using Plots
using GLM
using StatsBase

# Switch to Plotly backend for interactivity
plotly()

# Define factor levels
insulin_levels = [0.5, 1.0, 2.0]
zinc_levels = [0.75, 1.25, 1.5]
iron_levels = [0.40, 1.0, 1.60]
selenium_levels = [0.5, 0.75, 1.0]
codifier = ["Low", "Medium", "High"]

# Growth rate values (replace with your actual data)
growth_rate_values = [0.16460000000000002, 0.11900000000000002, 0.07340000000000002, 0.18960000000000005, 0.14400000000000002, 0.09840000000000003, 0.2146, 0.16900000000000004, 0.12340000000000002, 0.2106, 0.165, 0.1194, 0.2356, 0.19, 0.14440000000000003, 0.2606, 0.21500000000000002, 0.1694, 0.23360000000000003, 0.188, 0.14240000000000003, 0.25860000000000005, 0.21300000000000002, 0.16740000000000005, 0.2836, 0.23800000000000002, 0.19240000000000002, 0.29059999999999997, 0.24500000000000002, 0.19940000000000002, 0.3406, 0.29500000000000004, 0.2494, 0.3906, 0.34500000000000003, 0.2994, 0.3366, 0.29100000000000004, 0.24540000000000003, 0.38660000000000005, 0.341, 0.29540000000000005, 0.4366, 0.391, 0.34540000000000004, 0.35960000000000003, 0.31400000000000006, 0.2684000000000001, 0.4096000000000001, 0.36400000000000005, 0.31840000000000007, 0.45960000000000006, 0.41400000000000003, 0.36840000000000006, 0.5426, 0.497, 0.4514, 0.6426000000000001, 0.597, 0.5514000000000001, 0.7426, 0.6970000000000001, 0.6514, 0.5886, 0.5429999999999999, 0.4974, 0.6886000000000001, 0.643, 0.5974, 0.7886, 0.743, 0.6974, 0.6116, 0.5660000000000001, 0.5204, 0.7116, 0.666, 0.6204000000000001, 0.8116000000000001, 0.766, 0.7204]

# Create a DataFrame for codified variables with growth rate
codified_table = DataFrame(
    Insulin_levels = [codifier[i] for i in 1:length(insulin_levels) for _ in 1:length(zinc_levels) * length(selenium_levels) * length(iron_levels)],
    Zinc_levels = [codifier[j] for _ in 1:length(insulin_levels) for j in 1:length(zinc_levels) for _ in 1:length(selenium_levels) * length(iron_levels)],
    Selenium_levels = [codifier[k] for _ in 1:length(insulin_levels) * length(zinc_levels) for k in 1:length(selenium_levels) for _ in 1:length(iron_levels)],
    Iron_levels = [codifier[l] for _ in 1:length(insulin_levels) * length(zinc_levels) * length(selenium_levels) for l in 1:length(iron_levels)],
    GrowthRate = growth_rate_values[:]
)

println("Codified Table with Growth Rate:")
println(codified_table)

# Create a DataFrame for not codified (original) variables with growth rate
not_codified_table = DataFrame(
    Insulin = [n for n in insulin_levels for _ in 1:length(zinc_levels) * length(selenium_levels) * length(iron_levels)],
    Zinc = [t for _ in 1:length(insulin_levels) for t in zinc_levels for _ in 1:length(selenium_levels) * length(iron_levels)],
    Selenium = [s for _ in 1:length(insulin_levels) * length(zinc_levels) for s in selenium_levels for _ in 1:length(iron_levels)],
    Iron = [i for _ in 1:length(insulin_levels) * length(zinc_levels) * length(selenium_levels) for i in iron_levels],
    GrowthRate = growth_rate_values[:]
)

println("\nNot Codified Table with Growth Rate:")
println(not_codified_table)


data = not_codified_table
# Fit an ANOVA model
model = lm(@formula(GrowthRate ~ Insulin + Zinc + Selenium + Iron), data)
print(model)

# Calculate the correlation matrix for independent variables
correlation_matrix = cor(Matrix(data[:, 1:end-1]))

# Get the variable names (excluding the dependent variable GrowthRate)
variable_names = names(data[:, 1:end-1])

# Create a correlation heatmap
heatmap(
    variable_names,
    variable_names,
    correlation_matrix,
    color=:viridis,
    aspect_ratio=:equal,
    title="Correlation Heatmap of Independent Variables",
    xlabel="Variables",
    ylabel="Variables",
    c=:auto,
)
