<template>
        <div class="card bounder">
            <div class="row">
                <div style="font-size: 20px; margin-right: 450px; margin-left: 50px;">Мәтін синомайзері</div>
            </div>
            <hr height="20px">
            <div class="row">
                <div>
                    <div style="font-size: 12px; width: 500px;">
                        Мәтін синонимайзері қазақ тілінде енгізілген мәтіндегі сөздерді синонимдермен алмастыруға көмектеседі. Мәтіндегі сөз синонимдермен ауыстырылса жасыл түспен белгіленіп көрсетіледі. Синонимайзер арқылы өнделген мәтінге семантикасына қарай өзгеріс енгізу мүмкіндігі бар, ол үшін белгіленген сөздің үстінен басып, көрсетілген синонимдер ішінен мағынасына сай сөзді таңдап, түзете аласыз
                    </div>
                    <div class="card main-card" style="width: 500px; height: 500px; margin-top: 20px;">
                        <Textarea rows="15" cols="55" v-model="inputWords"/>
                        <div class="row texts" style="margin-top: 30px;">
                            <div>Символдар саны = {{ inputWords.length }}</div>
                            <div>Ауыстырылған сөздер саны = 0</div>
                            <Button label="Өңдеу" style="margin-left: 80px;"/>
                    </div>
                    <Textarea style="width: 446px; height: 112px; margin-top: 20px;" readonly="true"/>
                </div>

                </div>
                <div class="card temp" style="width: 500px; height: 560px;">
                    <div class="row">
                        <div>Сөзді енгізіңіз</div>
                        <InputText type="text" v-model="word" style="width: 230px;" />
                        <Button label="Іздеу" style="margin-left: 20px;" ></Button>
                    </div>
                    <div v-if="word.valueOf() != ''" style="padding-top: 20px;">
                    <div>
                        Сөз: {{ word }}
                    </div>

                    </div>
                </div>
            </div>
            <div class="card temp-mobile" style="width: 500px; height: 560px;">
                    <div class="row">
                        <div>Сөзді енгізіңіз</div>
                        <InputText type="text" v-model="word" style="width: 230px;" />
                        <Button label="Іздеу" style="margin-left: 20px;" ></Button>
                    </div>
                    <div v-if="word.valueOf() != ''" style="padding-top: 20px;">
                    <div>
                        Сөз: {{ word }}
                    </div>

                    </div>
                </div>
            </div>
</template>
<script setup>
import { ref, } from 'vue';
const word = ref('')
const inputWords = ref('');
</script>
<style setup>
.row{
  display: flex;
  align-items: center;
}
.row div{
  margin-right: 10px;
}
.texts{
    font-size: 10px;
    margin-top: 10px;
    
}
.rowMain{
    display: flex;
  align-items: center;
}
.temp-mobile{
    display: none;
}
/* .card ::v-deep .swticher {
  background-color: #324068;
  border-color: #324068;
} */
/* .dropDown{
    align-items: center;
} */
.dropDown{
    border-radius: 100px;
}
.bounder{
    /* //align-items: center; */
    height: 700px;
}
  /* Define the breakpoint where the menu will appear below the body */
  @media screen and (max-width: 1400px) {
  /* Hide the menu when the screen width is greater than or equal to the breakpoint */
  .temp {
    display: none;
  }
  .bounder{
    height: 1300px;
  }
  .temp-mobile{
    display: block;
  }
}
</style>