const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors());


mongoose.connect('mongodb://localhost:27017/mydatabase', { useNewUrlParser: true, useUnifiedTopology: true });

const DataSchema = new mongoose.Schema({
  data: String,
});

const Data = mongoose.model('Data', DataSchema);

app.post('/api/data', async (req, res) => {
  const newData = new Data({ data: req.body.data });
  await newData.save();
  res.send('Data saved');
});

app.get('/api/data', async (req, res) => {
  const data = await Data.find();
  res.json(data);
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
