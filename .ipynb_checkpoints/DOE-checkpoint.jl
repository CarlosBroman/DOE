using DataFrames
using Plots

# Define factor levels
nutrient_levels = [1.0, 2.0, 3.0, 4.0]
temperature_levels = [25.0, 30.0, 35.0, 40.0]
codifier = [0, 1, 2, 3]

# Growth rate values (replace with your actual data)
growth_rate_values = [
    0.172, 0.211, 0.276, 0.192,
    0.202, 0.209, 0.375, 0.233,
    0.315, 0.451, 0.722, 0.254,
    0.454, 0.626, 0.974, 0.222
]

# Create a DataFrame for codified variables with growth rate
codified_table = DataFrame(
    Nutrient = [codifier[i] for i in 1:length(nutrient_levels) for _ in 1:length(temperature_levels)],
    Temperature = [codifier[j] for _ in 1:length(nutrient_levels) for j in 1:length(temperature_levels)],
    GrowthRate = growth_rate_values[:]
)

println("Codified Table with Growth Rate:")
println(codified_table)

# Create a DataFrame for not codified (original) variables with growth rate
not_codified_table = DataFrame(
    Nutrient = [n for n in nutrient_levels for _ in 1:length(temperature_levels)],
    Temperature = [t for _ in 1:length(nutrient_levels) for t in temperature_levels],
    GrowthRate = growth_rate_values[:]
)

println("\nNot Codified Table with Growth Rate:")
println(not_codified_table)

# Perform data analysis, visualization, and optimization as needed
# ... (use statistical and optimization libraries)

# Create a 3D scatter plot
scatter3d(
    not_codified_table.Nutrient,
    not_codified_table.Temperature,
    not_codified_table.GrowthRate,
    xlabel="Nutrient",
    ylabel="Temperature",
    zlabel="Growth Rate",
    legend=false
)

# Report your findings