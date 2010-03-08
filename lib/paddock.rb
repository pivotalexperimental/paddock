module Paddock
  class FeatureNotFound < StandardError
  end

  class Feature
    def self.add(name, envs, disabled=false)
      @features ||= {}
      @features[name] = new(name, envs, disabled)
    end

    def self.get(name)
      (@features ||= {})[name] || raise(Paddock::FeatureNotFound.new("#{name} is not a valid feature."))
    end

    def initialize(name, envs, disabled)
      @name, @envs, @disabled = name, envs, disabled
    end

    def enabled?
      result = true if @envs == :all
      result ||= Array(@envs).map { |env| env.to_sym }.include?(Paddock.environment.to_sym)
      @disabled ? (!result) : result
    end
  end

  def self.environment=(env)
    @environment = env
  end

  def self.environment
    @environment
  end

  def self.features(&block)
    instance_eval(&block)
  end

  def self.enable(name, options={})
    Paddock::Feature.add(name, (options[:in] || :all))
  end

  def self.disable(name, options={})
    Paddock::Feature.add(name, (options[:in] || :all), :disabled)
  end

  def feature(name)
    enabled = Paddock::Feature.get(name).enabled?
    enabled && yield if block_given?
    enabled
  end
end

def Paddock(env, &block)
  if block_given?
    ::Paddock.environment = env
    ::Paddock.features(&block)
  else
    ::Paddock
  end
end
