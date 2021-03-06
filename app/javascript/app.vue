<template>
  <div id="app">   
    
    <div class="city-selector">
      <label for="all-keys">Selecciona una Ciudad!</label>
      <select v-model="cityChoice" name="city-key" id="all-keys" class="city-selector">
        <option v-for="city in cities" :key="city.key" :value="city">
          {{city.name}}, {{city.area}}, {{city.country}}, {{city.region}}
        </option>
      </select>

      <div class="graph-display">
        <canvas></canvas>
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
import Chart from "chart.js";

function chartConstructor(chartType, chartData, chartOptions) {
    const chartElement = document.querySelector("canvas");
    const chart = new Chart(chartElement, {
      type: chartType,
      data: chartData,
      options: chartOptions,
    });
    return chart;
}

function prepare_data(response) {
  const colors = [
    'Sunny',
    'Mostly Sunny',
    'Partly Sunny',
    'Intermittent Clouds',
    'Hazy Sunshine',
    'Mostly Cloudy',
    'Cloudy',
    'Dreary (Overcast)',
    'Fog',
    'Showers',
    'Mostly Cloudy w/ Showers',
    'Partly Sunny w/ Showers',
    'T-Storms',
    'Mostly Cloudy w/ T-Storms',
    'Partly Sunny w/ T-Storms',
    'Rain',
    'Flurries',
    'Mostly Cloudy w/ Flurries',
    'Partly Sunny w/ Flurries',
    'Snow',
    'Mostly Cloudy w/ Snow',
    'Ice',
    'Sleet',
    'Freezing Rain',
    'Rain and Snow',
  ];
  const date = response.DailyForecasts.map(f => new Date(f.Date));
  const temp = response.DailyForecasts.map(f => f.Temperature.Maximum.Value);
  const nubs = response.DailyForecasts.map(f => f.Day.IconPhrase);
  return {
    labels: date,
    datasets: [{
      label: 'Temperatura Máxima (°C)',
      data: temp,
      backgroundColor: nubs.map(n => {
        let i = colors.indexOf(n)
        let v = Math.ceil(255 * (colors.length - i) / colors.length)
        return `rgba(${v}, ${255 - v}, 128, 1)`
      }),
    }],
  }
}

export default {
  data: function () {
    return {
      cities: [],
      cityChoice: "",
      cityGraph: "",
      results: [],
      cityCreate: "",
      cityName: "",
      graph: "",
    }
  },
  created: async function () {
    const resp = await fetch('/api/v1/cities/');
    this.cities = await resp.json();
  },
  mounted: async function () {
    window.setInterval(async function () {
      const resp = await fetch(`/api/v1/cities/${this.cityChoice.key}`);
      this.cityGraph = JSON.parse(await resp.json());
      this.graph.destroy();
      this.graph = chartConstructor('bar', prepare_data(this.cityGraph), {});
    }, 60_000);
  },
  watch: {
    cityChoice: async function () {
      const resp = await fetch(`/api/v1/cities/${this.cityChoice.key}`);
      this.cityGraph = JSON.parse(await resp.json());
      if (this.graph !== "") {
        this.graph.destroy();
      }
      this.graph = chartConstructor('bar', prepare_data(this.cityGraph), {});
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
