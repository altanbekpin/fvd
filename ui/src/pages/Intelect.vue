<template>
    <div class="flex justify-center">
    <div class="card flex justify-center items-start">
      <Listbox v-model="selectedOnto" :options="OntNames" optionLabel="name" class="w-full md:w-14rem listbox-scrollable" />
    </div >
      <div v-html="this.OntoInner" class="card col"></div>
      <div>
</div>
  </div>
</template>


<script>
import axios from 'axios'

export default {
  name: 'Intelect',
  data() {
        return  {
        OntNames: [],
        selectedOnto: '',
        OntoInner: ''
    }
  },
  methods: {
    getJson(){
        axios.get('http://127.0.0.1:5001/getontology/').then(response => (this.OntNames =response.data))
    },
  },
  mounted() {
    this.getJson();
    console.log(this.OntNames.length)
  },
  watch:{
    // OntNames(newValue){
    //     console.log(newValue[0])
    // },
    async selectedOnto(){ 
        console.log(this.selectedOnto['name'])
        var reqbody = {
            'question': this.selectedOnto['name']
        }

        console.log(reqbody)
        var temp = await axios.post('http://127.0.0.1:5001/getontology/ask/', reqbody)
        this.OntoInner = temp.data
    }
  },
}
</script>
<style scoped>
.col{
    position: relative;
    width: 100%;
    padding-right: 15px;
    padding-left: 15px;
    display: block;
    max-width: 300px;
    margin-left: 15px;
}
.listbox-scrollable {
    max-height: 600px; /* set the maximum height of the ListBox */
    overflow: auto; /* set the overflow property to auto to enable scrolling */
  }
  .card-header:first-child {
    border-radius: calc(0.25rem - 1px) calc(0.25rem - 1px) 0 0;
}
.card-header {
    padding: 0.75rem 1.25rem;
    margin-bottom: 0;
    background-color: rgba(0, 0, 0, 0.03);
    border-bottom: 1px solid rgba(0, 0, 0, 0.125);
    box-sizing: border-box;
}
</style>