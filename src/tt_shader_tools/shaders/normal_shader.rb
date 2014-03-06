module TT::Plugins::ShaderTools

  require File.join(PATH_SHADERS, "base_shader.rb")

  class NormalShader < Shader

    def shade(face)
      rgb = face.normal.to_a.map { |value|
        # Normalize from values -1.0..1.0 to 0.0..1.0
        ratio = (value * 0.5) + 0.5
        (255 * ratio).to_i
      }
      material = material_from_rgb(rgb)
      face.material = material
      face.back_material = material
    end

  end # class NormalShader


end # module
