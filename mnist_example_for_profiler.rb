# frozen_string_literal: true

require 'dnn'

include DNN::Layers
include DNN::Activations
include DNN::Optimizers
include DNN::Losses
include DNN::Models

x_train = SFloat.cast Marshal.load(File.binread('x_train.dat'))
x_test  = SFloat.cast Marshal.load(File.binread('x_test.dat'))
y_train = SFloat.cast Marshal.load(File.binread('y_train.dat'))
y_test  = SFloat.cast Marshal.load(File.binread('y_test.dat'))

model = Sequential.new
model << InputLayer.new(784)
model << Dense.new(256)
model << ReLU.new
model << Dense.new(256)
model << ReLU.new
model << Dense.new(10)
model.setup(RMSProp.new, SoftmaxCrossEntropy.new)

model.train(x_train, y_train, 20, batch_size: 100, test: [x_test, y_test], verbose: true)
