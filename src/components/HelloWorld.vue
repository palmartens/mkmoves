<script setup>
  import jsondatanew from '../assets/MK1Moves.json'
  // import { ref } from 'vue'
</script>

<script >
  export default {
    data() {
      return {
        selectedFighter: this.getLastSelectedFighter(), //localStorage.getItem("selectedFighter") || "Scorpion",
        showButtons: this.getLastButtonState(),//localStorage.getItem('showButtons') ? localStorage.getItem('showButtons') : true,        
        selectedKameo: this.getLastSelectedKameo() //localStorage.getItem("selectedFighter") || "Scorpion",
      }
    },
    mounted: function() {      
      // this.showButtons = true; //localStorage.getItem('showButtons') ? localStorage.getItem('showButtons') : true;
    },
    methods: {
      selectFighter(name) {
        this.selectedFighter = name;
        localStorage.setItem("selectedFighter", name)
      },
      selectKameo(name) {
        this.selectedKameo = name;
        localStorage.setItem("selectedKameo", name)
      },
      toggleButtons(buttonsVisible) {           
        this.showButtons = !buttonsVisible;
        this.buttonText = this.showButtons ? "❌" : "👤";
        localStorage.setItem('showButtons',this.showButtons)
      },
      getLastButtonState() {       
        let lastState; 
        if (localStorage.getItem('showButtons')) {
          lastState = localStorage.getItem('showButtons') === 'true'
        } else {
          lastState =  true;
        }        
        this.buttonText = lastState ? "❌" : "👤";
        return lastState;
      },
      getLastSelectedFighter() {
        return localStorage.getItem('selectedFighter') || "Scorpion";
      },
      getLastSelectedKameo() {
        return localStorage.getItem('selectedKameo') || "Cyrax";
      }

    }
    
  }
</script>

<template>
  <!-- <span>ShowButtons: {{this.showButtons}} </span> -->
  <button class="toggle-btn" @click="toggleButtons(showButtons)">{{buttonText}}</button>
  <div class="btn-container-fighters" v-show="showButtons">
    <v-btn :class="['btn-select',{isSelected: fighter.name === selectedFighter }]"           
           width="100" 
           @click="selectFighter(fighter.name)" 
           variant="outlined" 
           v-for="fighter in jsondatanew.Fighters">{{ fighter.name }}</v-btn>
  </div>
  <div class="btn-container-kameos" v-show="showButtons">    
    <v-btn :class="['btn-select',{isSelectedK: kameo.name === selectedKameo }]"  
           width="100" 
           @click="selectKameo(kameo.name)" 
           variant="outlined" 
           v-for="kameo in jsondatanew.Kameos">{{ kameo.name }}</v-btn>
  </div>

    <template v-for="fighter in jsondatanew.Fighters">
        <v-card color="#242424" v-show="fighter.name === selectedFighter">
          <template v-slot:title>{{fighter.name}}</template>
          <template v-slot:text>
            <h4>Normal attacks</h4>    
            <v-row no-gutters v-for="normalattack in fighter['Normal Attacks']">      
              <v-col>{{normalattack.name}}</v-col>
              <v-col>{{ normalattack.value }}</v-col>
            </v-row>
            <hr color="gray">
            <h4>Special moves</h4>        
            <v-row no-gutters v-for="specialmove in fighter['Special Moves']">
              <v-col>{{specialmove.name}}</v-col>
              <v-col>{{specialmove.value }}</v-col>
            </v-row>
            <hr color="gray">
            <h4>Kombos</h4>        
            <v-row no-gutters v-for="kombo in fighter['Kombos']">
              <v-col>{{kombo.name}}</v-col>
              <v-col>{{kombo.value }}</v-col>
            </v-row>
            <h4>Air Kombos</h4>
            <v-row no-gutters v-for="kombo in fighter['Aerial Kombos']">
              <v-col>{{kombo.name}}</v-col>
              <v-col>{{kombo.value }}</v-col>
            </v-row>
            <hr color="gray">
            <h4 class="finisher">Fatalities</h4>    
            <v-row no-gutters v-for="fatality in fighter['Finishing Moves']['Fatalities']">
              <v-col>{{fatality.name}}</v-col>
              <v-col>{{fatality.value }}</v-col>    
            </v-row>
            <h4 class="finisher">Brutalities</h4>    
            <v-row no-gutters v-for="brutality in fighter['Finishing Moves']['Brutalities']">
              <v-col>{{brutality.name}}</v-col>
              <v-col>{{ brutality.value }}</v-col>
            </v-row>
            <hr color="gray">
          </template>          
        </v-card>  
      </template>
     <template v-for="kameo in jsondatanew.Kameos">
        <v-card color="#242424" v-show="kameo.name === selectedKameo">
          <template v-slot:title>{{kameo.name}}</template>
          <template v-slot:text>      
            <h4>Special moves</h4>        
            <v-row no-gutters v-for="specialmove in kameo['Special Moves']">
              <v-col>{{specialmove.name}}</v-col>
              <v-col>{{specialmove.value }}</v-col>
            </v-row>
            <hr color="gray">
            <h4 class="finisher">Fatalities</h4>    
            <v-row no-gutters v-for="fatality in kameo['Finishing Moves']['Kameo Fatalities']">
              <v-col>{{fatality.name}}</v-col>
              <v-col>{{fatality.value }}</v-col>    
            </v-row>
            <h4 class="finisher">Brutalities</h4>    
            <v-row no-gutters v-for="brutality in kameo['Finishing Moves']['Kameo Brutalities']">
              <v-col>{{brutality.name}}</v-col>
              <v-col>{{ brutality.value }}</v-col>
            </v-row>
            <hr color="gray">
          </template>          
        </v-card>  
      </template>
  
  


</template>

<style scoped>
.read-the-docs {
  color: #888;
}
.card {
  font-size: 10pt;
}
h2 {
  color: lightgray;
  margin-bottom:0;  
}
h4 {
  color: #FFCC00;
  margin-bottom:5px;
  margin-top: 0.5em;  
  font-size:11pt;
}
h4.finisher {
  color:red;   
  font-size:10pt;
}
.toggle-btn {
  
  float: right;
}
.btn-container-fighters {
  margin-bottom:10px;  
  border-bottom: 1px solid grey;
}
.btn-select {
  margin:0px 8px 8px 0px;   
}
.isSelected {
  background-color: #aa7d00;
}
.isSelectedK {
  background-color: #885500;
}
</style>
