export const AHMET_API = process.env.VUE_APP_API_URL

export const getHeader = function() {
    return {
        'Access-Control-Allow-Credentials':'true',
        'Content-Type': 'application/json',
        'Accept':"*/*"
      }
}