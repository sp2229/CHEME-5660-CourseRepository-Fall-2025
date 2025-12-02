abstract type AbstractWorldModel end
abstract type AbstractSamplingModel end
abstract type AbstractInvestorContextModel end

"""
    mutable struct MyTickerPickerSIMRiskAwareWorldModel <: AbstractWorldModel

The `MyTickerPickerSIMRiskAwareWorldModel` mutable struct represents a world model for a ticker picker problem 
that is risk-aware and uses a single index model (SIM) for returns.

### Required fields
- `tickers::Array{String,1}`: An array of ticker symbols that we explore
- `risk_free_rate::Float64`: The risk-free rate of return in the world (assumed constant)
- `world::Function`: A function that represents the world model. The function takes an action `a`, data about the world, and returns the reward `r` for taking action `a`.
- `Δt::Float64`: The time step size in the world model
- `Ḡₘ::Float64`: The expected excess market return (market factor)
- `parameters::Dict{String, NamedTuple}`: A dictionary that holds the single index model parameters for each ticker symbol
- `buffersize::Int64`: The size of the buffer used in the world model
- `risk::Dict{String, Float64}`: A dictionary that holds the risk measure for each ticker symbol
"""
mutable struct MyTickerPickerSIMRiskAwareWorldModel <: AbstractWorldModel

    # data -
    tickers::Array{String,1}
    risk_free_rate::Float64
    world::Function
    Δt::Float64
    Ḡₘ::Float64 # expected excess market return (market factor)
    parameters::Dict{String, NamedTuple} # single index model parameters for each ticker
    buffersize::Int64 # how many days to use in the buffer
    risk::Dict{String, Float64}

    # constructor -
    MyTickerPickerSIMRiskAwareWorldModel() = new();
end

"""
    mutable struct MyEpsilonSamplingBanditModel <: AbstractSamplingModel

The `MyEpsilonSamplingBanditModel` mutable struct represents a multi-armed bandit model that uses epsilon-sampling for exploration.

### Required fields
- `α::Array{Float64,1}`: A vector holding the number of successful pulls for each arm. Each element in the vector represents the number of successful pulls for a specific arm.
- `β::Array{Float64,1}`: A vector holding the number of unsuccessful pulls for each arm. Each element in the vector represents the number of unsuccessful pulls for a specific arm.
- `K::Int64`: The number of arms in the bandit model
- `ϵ::Float64`: The exploration parameter. A value of `0.0` indicates no exploration, and a value of `1.0` indicates full exploration.
"""
mutable struct MyEpsilonSamplingBanditModel <: AbstractSamplingModel

    # data -
    α::Array{Float64,1}
    β::Array{Float64,1}
    K::Int64

    # constructor -
    MyEpsilonSamplingBanditModel() = new();
end

mutable struct MyInvestorMarketContextModel <: AbstractInvestorContextModel

    # data -
    B::Float64 # total budget for investment (in USD)
    tickers::Array{String,1} # array of ticker symbols
    marketdata::Dict{String, DataFrame} # market data for the tickers
    preferences::Dict{Symbol, DataFrame} # ticker-picker preferences
    Ḡₘ::Float64 # expected excess market return (market factor)
    risk_free_rate::Float64 # risk-free rate of return
    singleindexmodel_parameters::Dict{String, NamedTuple} # single index model parameters for each ticker
    ξ::Float64 # weight of the ticker-picker preference in the investor context model
    mood::Symbol # mood of the investor (:optimistic, :neutral, :pessimistic)
    ϵ::Float64 # minimum number of shares to buy/sell per trade

    # constructor -
    MyInvestorMarketContextModel() = new();
end