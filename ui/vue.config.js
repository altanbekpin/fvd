process.env.VUE_APP_AHMET_API = "http://kazlangres.enu.kz";
process.env.HOST = "kazlangres.enu.kz";
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
