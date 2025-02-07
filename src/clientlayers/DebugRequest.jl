module DebugRequest

using Logging, LoggingExtras
import ..DEBUG_LEVEL

export debuglayer

"""
    debuglayer(handler) -> handler

If `verbose` keyword arg is > 0, or the HTTP.jl global `DEBUG_LEVEL[]` is > 0,
then enabled debug logging with verbosity `verbose` for the lifetime of the request.
"""
function debuglayer(handler)
    return function(request; verbose=0, kw...)
        # if debugging, enable by wrapping request in custom logger logic
        if verbose > 0 || DEBUG_LEVEL[] > 0
            LoggingExtras.withlevel(Logging.Debug; verbosity=verbose) do
                handler(request; verbose=verbose, kw...)
            end
        else
            return handler(request; verbose, kw...)
        end
    end
end

end # module DebugRequest
