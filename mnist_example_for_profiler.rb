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

model << InputLayer.new([28, 28, 1])

model << Conv2D.new(16, 5)
model << BatchNormalization.new
model << ReLU.new

model << MaxPool2D.new(2)

model << Conv2D.new(32, 5)
model << BatchNormalization.new
model << ReLU.new

model << Flatten.new

model << Dense.new(256)
model << BatchNormalization.new
model << ReLU.new
model << Dropout.new(0.5)

model << Dense.new(10)

model.setup(Adam.new, SoftmaxCrossEntropy.new)

model.train(x_train, y_train, 10, batch_size: 100, test: [x_test, y_test])
