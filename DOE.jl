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
growth_rate_values = [0.075, 0.069, 0.073, 0.080, 0.079, 0.098, 0.085, 0.099, 0.083,
                    0.111, 0.125, 0.129, 0.126, 0.110, 0.124, 0.111, 0.115, 0.099,
                    0.114, 0.118, 0.122, 0.119, 0.133, 0.117, 0.124, 0.138, 0.132,
                    0.241, 0.245, 0.169, 0.271, 0.285, 0.289, 0.311, 0.345, 0.349,
                    0.207, 0.221, 0.255, 0.297, 0.251, 0.295, 0.337, 0.391, 0.345,
                    0.330, 0.314, 0.268, 0.330, 0.354, 0.318, 0.360, 0.414, 0.368,
                    0.433, 0.407, 0.441, 0.623, 0.597, 0.581, 0.793, 0.857, 0.891,
                    0.429, 0.503, 0.497, 0.679, 0.613, 0.597, 0.859, 0.843, 0.897,
                    0.412, 0.506, 0.420, 0.692, 0.676, 0.620, 0.912, 0.906, 0.950
                    ]

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

# Calculate the correlation matrix between independent variables and the dependent variable
correlation_matrix = cor(Matrix(not_codified_table[:, 1:end-1]), not_codified_table[:, end])

# Get the variable names (excluding the dependent variable GrowthRate)
variable_names = names(not_codified_table[:, 1:end-1])

# Create a bar plot to visualize the correlations
bar(
    variable_names,
    correlation_matrix,
    xlabel="Variables",
    ylabel="Correlation with GrowthRate",
    title="Correlation between Independent Variables and GrowthRate",
    legend=false,
    color=:blue,
)