<template>
  <div id="app">
    
    <h1>Henry's Simple Weather Web App</h1>
    
    
    <div class="city-selector">
      <label for="all-keys">Selecciona una Ciudad!</label>
      <select v-model="cityChoice" name="city-key" id="all-keys" class="city-selector">
        <option v-for="city in cities" :key="city.key" :value="city">
          {{city.name}}, {{city.area}}, {{city.country}}, {{city.region}}
        </option>
      </select>

      <div class="graph-display">
        <p class="res">{{ cityGraph }}</p>
      </div>

    </div>
    
    
    <div class="city-creator">
      <label for="city-add-name">No encuentras tu ciudad? Agregala!</label>
      <input v-model.lazy="cityName" type="search" name="city-name" id="city-add-name" />
      <p>{{ cityName }}</p>
      <label for="city-create">Escoge la Ciudad a la que te refieres!</label>
      <select v-model="cityCreate" name="city-key" id="all-keys" class="city-selector">
        <option v-for="result in results" :key="result.key" :value="result">
          {{result.name}}, {{result.area}}, {{result.country}}, {{result.region}}
        </option>
      </select>
    </div>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      cities: [],
      cityChoice: "NAO",
      cityGraph: "NAG",
      results: [],
      cityCreate: "NAO",
      cityName: "",
    }
  },
  created: async function () {
    const resp = await fetch('/api/v1/cities/');
    this.cities = await resp.json();
  },
  mounted: async function () {
    window.setInterval(async function () {
      const resp = await fetch(`/api/v1/cities/${this.cityChoice.key}`);
      this.cityGraph = await resp.json();
    }, 60_000);
  },
  watch: {
    cityChoice: async function () {
      const resp = await fetch(`/api/v1/cities/${this.cityChoice.key}`);
      this.cityGraph = await resp.json();
    },
    cityName: async function () {
      if (this.cityName.length > 0) {
        const resp = await fetch(`/api/v1/cities/find/${this.cityName}`);
        this.results = JSON.parse(await resp.json())
        console.log(this.results)
      }
    },
    cityCreate: async function (currVal, oldVal) {
      if (typeof(currVal) !== "string") {
        const resp = await fetch(`/api/v1/cities/create`, {
          method: 'POST',
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(currVal),
        });
        const newCity = await resp.json();
        this.cities.push(newCity);
      }
    },
    cities: function () {
      this.cityCreate = "NAN";
      this.cityName = "";
    },
  },
  methods: {},
}
</script>
