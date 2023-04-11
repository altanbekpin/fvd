process.env.VUE_APP_AHMET_API = "http://127.0.0.1:5001"
module.exports = {
	pluginOptions: {
		i18n: {
		  locale: 'kz',
		  fallbackLocale: 'en',
		  enableInSFC: false
		},
		
	},
	
	publicPath: process.env.NODE_ENV === 'production' ? '/' : '/'
}