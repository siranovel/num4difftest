Gem::Specification.new do |s|
  s.name        = 'num4difftest'
  s.version     = '0.0.2'
  s.date        = '2024-05-18'
  s.summary     = "test of difference!"
  s.description = "test of difference of population mean."
  s.authors     = ["siranovel"]
  s.email       = "siranovel@gmail.com"
  s.homepage    = "https://github.com/siranovel/num4difftest"
  s.license     = "MIT"
  s.files       = ["LICENSE", "Gemfile", "CHANGELOG.md"]
  s.files       += Dir.glob("{lib,ext}/**/*")
  s.add_development_dependency 'num4tststatistic2', '~> 0.2', '>= 0.2.1'
  s.add_development_dependency 'num4anova', '~> 0.1', '>= 0.1.1'
end
