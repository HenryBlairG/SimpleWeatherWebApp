<template>
  <div class="app-wrapper" id="app">   
    
    <div class="city-selector">

      <div class="graph-display">
        <label for="all-keys">Choose a city!</label>
        <select v-model="cityChoice" name="city-key" id="all-keys" class="city-selector">
          <option v-for="city in cities" :key="city.key" :value="city">
            {{city.name}}, {{city.area}}, {{city.country}}, {{city.region}}
          </option>
        </select>
        <canvas></canvas>
      </div>

      <div class="wind-display">
        <h2 v-if="status.length > 0"> {{status}} </h2>
        <div class="compass obj">
          <img v-bind:src="Compass">
          <p>{{speed}} Km/h, {{degrees}}°AZV</p>
        </div>
        <div class="arrow obj">
          <img v-bind:src="Arrow" :style="updateArrow">
        </div>
      </div>

    </div>
    
  
    <div class="city-creator">
      <label for="city-add-name">Didn't find your city? Add it!</label>
      <input v-model.lazy="cityName" type="search" name="city-name" id="city-add-name" />
      <div v-show="cityName.length > 0" class="results">
        <p>Results for {{ cityName }}</p>
        <label for="city-create">Choose your city!</label>
        <select v-model="cityCreate" name="city-key" id="all-keys" class="city-selector">
          <option v-for="result in results" :key="result.key" :value="result">
            {{result.name}}, {{result.area}}, {{result.country}}, {{result.region}}
          </option>
        </select>
      </div>
    </div>
  </div>
</template>

<script>
import Chart from "chart.js";
import Compass from "images/compass.png"
import Arrow from "images/arrow.png"

function chartConstructor(chartType, chartData, chartOptions) {
    const chartElement = document.querySelector("canvas");
    const chart = new Chart(chartElement, {
      type: chartType,
      data: chartData,
      options: chartOptions,
    });
    return chart;
}

function prepare_wind(response) {
  return {
    speed: response.DailyForecasts[0].Day.Wind.Speed.Value,
    direction: response.DailyForecasts[0].Day.Wind.Direction.Degrees,
  };
}

function prepare_data(response) {
  const colors = ['red', 'blue', 'green', 'yellow', 'purple'];
  const icons = response.DailyForecasts.map(f => f.Day.Icon);
  let nubDict = new Map()
  for (let i = 0; i < icons.length; i++) {
    nubDict.set(icons[i], colors[i]);
  }
  nubDict = Object.fromEntries(nubDict);
  const date = response.DailyForecasts.map(f => new Date(f.Date).toDateString());
  const temp = response.DailyForecasts.map(f => new Number(f.Temperature.Maximum.Value));
  const nubs = response.DailyForecasts.map((f) => {
    return {title: f.Day.IconPhrase, value: f.Day.Icon, color: nubDict[f.Day.Icon]}
  });
  
  return {
    labels: nubs.map((f, i) => {
      return `${date[i]}\n(${f.title})`
    }),
    datasets: [{
      label: 'Max Temperature (°C)',
      data: date.map((e, i) => {
        return {x: e, y: temp[i]}
      }),
      backgroundColor: nubs.map(f => f.color),
      minBarLength: 2,
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
      graph: null,
      status: "",
      speed: "",
      degrees: "",
      Compass,
      Arrow,
    }
  },
  created: async function () {
    this.status = "Fetching Data...";
    const resp = await fetch('/api/v1/cities/');
    this.status = "Data Ready!";
    this.cities = await resp.json();
    await new Promise(r => setTimeout(r, 1000))
    this.status = "";
  },
  mounted: async function () {
    window.setInterval(this.reload, 60_000);
  },
  watch: {
    cityChoice: async function () {
      if (this.cityChoice !== "") {
        this.status = "Fetching Forecast...";
        const resp = await fetch(`/api/v1/cities/${this.cityChoice.key}`);
        this.status = "Data Ready!";
        this.cityGraph = JSON.parse(await resp.json());
        this.graph?.destroy();
        await new Promise(r => setTimeout(r, 1000))
        const mydata = prepare_data(this.cityGraph);
        const myoptions = {
          title: {
            display: true,
            text: 'Max Temperature (°C)'
          },
          scales: {
            xAxes: [{
              ticks: {
                min: 0
              }
            }]
          },
          legend: {
            display: false
          },
          tooltips: {
            enabled: false
          },
        }
        this.graph = chartConstructor('bar', mydata, myoptions);
        const wind = prepare_wind(this.cityGraph);
        this.speed = wind.speed;
        this.degrees = wind.direction;
        this.status = "";
      }
      
    },
    cityName: async function () {
      if (this.cityName.length > 0) {
        const resp = await fetch(`/api/v1/cities/find/${this.cityName}`);
        this.results = JSON.parse(await resp.json())
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
        this.cities.unshift(newCity);
      }
    },
    cities: function () {
      this.cityCreate = "NAN";
      this.cityName = "";
    },
  },
  methods: {
    reload: async function () {
      if (this.cityChoice && this.cityChoice !== "") {
        this.status = "Reloading Forecast...";
        const resp = await fetch(`/api/v1/cities/${this.cityChoice.key}`);
        this.status = "Data Ready!";
        this.cityGraph = JSON.parse(await resp.json());
        this.graph?.destroy();
        await new Promise(r => setTimeout(r, 1000));
        const mydata = prepare_data(this.cityGraph);
        this.graph = chartConstructor('bar', mydata, {});
        const wind = prepare_wind(this.cityGraph);
        this.speed = wind.speed;
        this.degrees = wind.direction;
        this.status = "";
      }
    },
  },
  computed: {
    updateArrow: function () {
      return {
        transform: 'rotate(' + (this.degrees) + 'deg)',
      }
    }
  },
}

</script>
