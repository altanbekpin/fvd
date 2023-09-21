module.exports = {
  pluginOptions: {
    i18n: {
      locale: "kz",
      fallbackLocale: "en",
      enableInSFC: false,
    },
  },
  configureWebpack: {
    module: {
      rules: [
        {
          test: /\.cjs$/,
          loader: "babel-loader", // You can use the appropriate loader for your use case
        },
      ],
    },
  },
  publicPath: process.env.NODE_ENV === "production" ? "/" : "/",
};
