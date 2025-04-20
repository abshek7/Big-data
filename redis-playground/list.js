const client = require('./client');

async function init(){
   await client.lpush("messages", "hello world");
    await client.lpush("messages", "hello world again");
    await client.lpush("messages", "hello world again and again");
    const result=await client.rpop("messages");
    // const result=await client.blpop("messages", 0);
   console.log(result); // 3
  }
  init();