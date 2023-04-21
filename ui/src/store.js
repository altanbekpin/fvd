import { createStore } from 'vuex'
import createPersistedState from 'vuex-persistedstate'
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
