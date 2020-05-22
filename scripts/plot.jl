"""
plot.jl
"""

using DelimitedFiles
using Plots

WDIR = ENV["PHYS_WPD5_PATH"]
ASSETS_PATH = joinpath(WDIR, "assets")
DATA_PATH = joinpath(WDIR, "data")

EXP3_DATA_PATH = joinpath(DATA_PATH, "exp3.tsv")
EXP3_SAVE_PATH = joinpath(ASSETS_PATH, "exp3.png")
EXP5_DATA_PATH = joinpath(DATA_PATH, "exp5.tsv")
EXP5_SAVE_PATH = joinpath(ASSETS_PATH, "exp5.png")

DPI = 300
TAB_DELIM = '\t'
EOL = '\n'


"""
plot_data - Plot data.

Arguments:
data :: ndarray(4 x N) - A matrix containing data from a piezo voltage sweep.

Returns: nothing
"""
function plot_data(data_path, save_path, title)
    # Grab data.
    metadata = readdlm(data_path, TAB_DELIM, Float64, EOL, header=true)
    data = metadata[1]
    voltages = data[:, 1]
    c_rate = data[:, 3]
    dc_rate = map(sqrt, c_rate)
    d_rate = data[:, 4]
    dd_rate = map(sqrt, d_rate)
    
    # Plot.
    fig = Plots.plot(voltages, c_rate, color="blue", label=nothing)
    Plots.plot!(voltages, d_rate, color="red", label=nothing)
    Plots.scatter!(voltages, c_rate, yerr=dc_rate, label="A&C Coincidences", color="blue")
    Plots.scatter!(voltages, d_rate, yerr=dd_rate, label="A&D Coincidences", color="red", dpi=DPI)
    Plots.xlabel!("Piezo Voltage (V)")
    Plots.ylabel!("Rate (counts / s)")
    if !isnothing(title)
        Plots.title!(title)
    end
    Plots.savefig(fig, save_path)
end


"""
main - Plot all the things.
"""
function main()
    if false
        plot_data(EXP3_DATA_PATH, EXP3_SAVE_PATH, "Experiment 3")
    end

    if false
        plot_data(EXP5_DATA_PATH, EXP5_SAVE_PATH, "Experiment 5")
    end
end
