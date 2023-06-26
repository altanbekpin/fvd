export const AHMET_API = "http://localhost:5001";
//"http://localhost:5001";

export const getHeader = function () {
  return {
    "Access-Control-Allow-Credentials": "true",
    "Content-Type": "application/json",
    Accept: "*/*",
  };
};
