//want to speed up api responses using redis client

const express = require('express');
const axios = require('axios');
const client = require('./client');
const app = express();

app.get('/',async (req, res) => {

   const cacheValue=await client.get('todos');

   if (cacheValue)  return res.json(JSON.parse(cacheValue));

 try {
    const {data} = await axios.get('https://jsonplaceholder.typicode.com/todos');
    await client.set('todos', JSON.stringify(data));
    await client.expire('todos', 10); // 10 seconds
    res.json(data);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Failed to fetch todos' });
  }
});

app.listen(6969);