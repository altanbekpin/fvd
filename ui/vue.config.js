process.env.VUE_APP_AHMET_API = "http://localhost:5001";
module.exports = {
  pluginOptions: {
    i18n: {
      locale: "kz",
      fallbackLocale: "en",
      enableInSFC: false,
    },
  },

  publicPath: process.env.NODE_ENV === "production" ? "/" : "/",
};
