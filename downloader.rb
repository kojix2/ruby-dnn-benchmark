# frozen_string_literal: true

require 'dnn'
require 'dnn/datasets/mnist'

MNIST = DNN::MNIST
x_train, y_train = MNIST.load_train
x_test, y_test = MNIST.load_test

x_train = Numo::SFloat.cast(x_train)
x_test = Numo::SFloat.cast(x_test)

x_train /= 255
x_test /= 255

y_train = DNN::Utils.to_categorical(y_train, 10, Numo::SFloat)
y_test = DNN::Utils.to_categorical(y_test, 10, Numo::SFloat)

%w(x_train x_test y_train y_test).each do |v|
  File.binwrite( v + ".dat", Marshal.dump(eval(v)))
end
