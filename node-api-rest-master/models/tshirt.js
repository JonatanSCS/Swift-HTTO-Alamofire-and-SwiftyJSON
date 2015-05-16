var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var Images = new Schema({
    kind: {
        type: String,
        enum: ['thumbnail', 'detail'],
        required: true
    },
    url: { type: String, required: true }
});

var Tshirt = new Schema({
  model:    { type: String, require: true },
  images:    [Images],
  style:    { type: String, 
              require: true 
            },
  size:     { type: String, 
              require: true 
            },
  colour:   { type: String, require: true },
  price :   { type: String, require: true },
  summary:  { type: String, require: true },
  modified: { type: Date, default: Date.now }    
});

Tshirt.path('model').validate(function (v) {
    return ((v != "") && (v != null));
});

module.exports = mongoose.model('Tshirt', Tshirt);