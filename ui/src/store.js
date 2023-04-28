import { createStore } from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import Cookies from 'js-cookie'
//import VuexPersistence from 'vuex-persist'
// const vuexLocal = new VuexPersistence({
//   storage: window.localStorage,
// });

const store = createStore({
  state: {
    user: {
      email: '',
      password: '',
      roles: [],
      access_token: ''
    },
    ChosenTheme: {
      theme: 'bootstrap4-light-blue',
      dark: false
    }
  },
  mutations: {
    updateUser(state, data) {
      console.log('updateUser:')
      console.log(data)
      state.user = data;
      console.log('state after updating:')
      console.log(state.user)
      localStorage.setItem('user', JSON.stringify(data));
    },
    changeTheme(state, Theme){
      Cookies.set('Theme', Theme, { expires: 7 })
      state.ChosenTheme.theme = Theme.theme
      state.ChosenTheme.dark = Theme.dark
      console.log(state.ChosenTheme)
    }
    // Define your state mutations here
  },
  actions: {
    // Define your actions here
  },
  getters: {
    getRoles: state => {
      if (state.user) {
        return state.user.roles;
      } else {
        return [];
      }
  }
  },
  plugins: [createPersistedState({
    storage: window.sessionStorage,
})],
  //plugins: [vuexLocal.plugin],
})
export default store
