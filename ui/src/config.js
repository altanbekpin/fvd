export const AHMET_API = process.env.VUE_APP_API_URL;
//"http://localhost:5001";
export const getHeader = function (access_token = "") {
  return {
    "Access-Control-Allow-Credentials": "true",
    "Content-Type": "application/json",
    Accept: "*/*",
    Authorization: `Bearer ${access_token}`,
  };
};
