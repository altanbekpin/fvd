import axios from "axios";
import { AhmetService } from "./AhmetService";
const instance = axios.create({});

instance.interceptors.response.use(
  (response) => response,
  async (error) => {
    // You can handle specific error cases here
    if (error.response) {
      const { status } = error.response;

      if (status === 401) {
        // Call the refresh_token() function here
        try {
          await AhmetService.refresh_token(); // Assuming refresh_token() returns a Promise
          // Retry the original request after refreshing the token
          const originalRequest = error.config;
          return instance(originalRequest);
        } catch (refreshError) {
          // Handle the error from refresh_token() if needed
          console.error("Error refreshing token:", refreshError);
        }
      }

      // Log the error details
      console.error("Response Error:", error.response.data);
      console.error("Response Status:", status);
      console.error("Response Headers:", error.response.headers);
    } else if (error.request) {
      // The request was made but no response was received
      console.error("Request Error:", error.request);
    } else {
      // Something happened in setting up the request that triggered an Error
      console.error("Generic Error:", error.message);
    }

    return Promise.reject(error); // Pass the error along to the calling code
  }
);

export default instance;
