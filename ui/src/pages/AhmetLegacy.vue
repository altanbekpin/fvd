<template>
    <div class="card flex justify-content-center">
        <!-- <Tree :value="nodes" @node-expand="onNodeExpand" :loading="loading"  class="w-full"></Tree> -->
        <TreeTable :value="nodes" @node-expand="onNodeExpand">
            <!-- <Column headerStyle="width: 10rem" :expander="true">
                <template #body="slotProps">
                    <i :class="slotProps.data.icon" style="font-size: 2rem"></i>
                </template>
            </Column> -->
            <Column  headerStyle="width:3rem" :expander="true">
                
            </Column>
            <Column :field="label" header="Атауы">
                <template #body="slotProps">
                    <i :class="slotProps.node.icon"/>
                    <span class="pl-2">{{slotProps.node.label}}</span>
                </template>
            </Column>
            <Column  headerStyle="width:4rem">
                <template #body="slotProps">
                    <Button v-if="slotProps.node.is_file" type="button" icon="pi pi-download" @click="getFile(slotProps.node.key)" rounded/>
                </template>
            </Column>

            
        </TreeTable>
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { AhmetService } from '@/service/AhmetService';

const nodes = ref(null);
const loading = ref(false);

onMounted(() => {
    loading.value =true
    AhmetService.getTreeTableNodes().then((data) => {
        loading.value = false
        let legacies = data.data;
        for (var i=0;legacies.length; i++) {
            legacies[i].key = String(legacies[i].key)
            if(legacies[i].is_file  === 0) {
                legacies[i].leaf = false
            }
            nodes.value = legacies
        }
    });
});
const onNodeExpand = (node) => {
    loading.value = true
    AhmetService.getTreeTableNodes(node.key).then(data => {
        
        loading.value = false
        let legacies = data.data;
        for (var i=0;legacies.length; i++) {
            legacies[i].key = String(legacies[i].key)
            if(legacies[i].is_file  === 0) {
                legacies[i].leaf = false
            }
            node.children = legacies
        }
    });
}
const getFile = (fileID) => {
  AhmetService.getFile(fileID)
};

</script>