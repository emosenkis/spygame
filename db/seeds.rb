# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.new
user.name='Eitan'
user.email='eitan@mosenkis.net'
user.password='123456'
user.password_confirmation='123456'
user.save

user = User.new
user.name='Ezra'
user.email='ezraskolnik@gmail.com'
user.password='123456'
user.password_confirmation='123456'
user.save

user = User.new
user.name='Tom'
user.email='trample68@163.com'
user.password='123456'
user.password_confirmation='123456'
user.save

user = User.new
user.name='Shu Lin'
user.email='shulin.chan@gmail.com'
user.password='123456'
user.password_confirmation='123456'
user.save

