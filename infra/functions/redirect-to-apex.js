// Redirects www.<domain> to the apex. Runs at the CloudFront edge on every
// viewer request, before the cache.
//
// This exists because cookies are scoped per HOST. The refresh token is set on
// whichever hostname signed you in, so with both hosts serving the app, signing
// in on www and later opening the apex looks exactly like being signed out at
// random — and the study data, which is keyed by account, appears to have
// vanished. One canonical host removes the whole class of problem.
//
// Terraform renders ${apex} from var.domain_name; everything else is literal.
// This is CloudFront Functions JS 2.0, which is not Node: no require, no fetch,
// no async, ~1ms of CPU. Keep it arithmetic-simple.
function handler(event) {
    var request = event.request;
    var host = request.headers.host ? request.headers.host.value : '';

    if (host.toLowerCase() !== 'www.${apex}') {
        return request;
    }

    // The query string is rebuilt rather than dropped. Verification and reset
    // links carry ?token=..., and silently losing it would turn a working link
    // into an invalid-token error page with nothing to debug from.
    var query = [];
    for (var key in request.querystring) {
        var parameter = request.querystring[key];
        if (parameter.multiValue) {
            for (var i = 0; i < parameter.multiValue.length; i++) {
                query.push(key + '=' + parameter.multiValue[i].value);
            }
        }
        else {
            query.push(key + '=' + parameter.value);
        }
    }

    var suffix = query.length ? '?' + query.join('&') : '';

    return {
        statusCode: 301,
        statusDescription: 'Moved Permanently',
        headers: {
            location: { value: 'https://${apex}' + request.uri + suffix },
            // A permanent redirect gets cached by browsers for a long time, so
            // say so explicitly rather than leaving it to their defaults.
            'cache-control': { value: 'max-age=3600' }
        }
    };
}
