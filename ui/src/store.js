import { createStore } from 'vuex'
//import createPersistedState from 'vuex-persistedstate'
import VuexPersistence from 'vuex-persist'
const vuexLocal = new VuexPersistence({
  storage: window.localStorage,
});

const store = createStore({
  state: {
    email: '',
    password: '',
    roles: []
  },
  mutations: {
    
    // Define your state mutations here
  },
  actions: {
    // Define your actions here
  },
  getters: {
    // permitions: (state) => (role) =>{
    //   console.log(state.roles)
    //   console.log(state.roles[2])
    //   return (state.roles.indexOf(role) !== -1)
    // }
  },
  plugins: [vuexLocal.plugin],
})
export default store
