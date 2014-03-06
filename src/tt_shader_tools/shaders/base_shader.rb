module TT::Plugins::ShaderTools


  # Base shader interface which all shaders should inherit from.
  class Shader

    def shade(face)
      raise NotImplementedError, "Sub-classes should implement this"
    end

    def material_from_rgb(rgb_array)
      # Re-use existing materials if possible.
      # NOTE: Things will be messed up if the user has modified a previously
      # created material.
      materials = Sketchup.active_model.materials
      material_name = "#{self.class.name} RGB(#{rgb_array})"
      material = materials[material_name]
      return material if !material.nil?

      # Create new material as needed.
      material = Sketchup.active_model.materials.add(material_name)
      material.color = Sketchup::Color.new(rgb_array)
      material
    end

    def name
      self.class.name.split("::").last
    end

  end # class Shader


end # module
