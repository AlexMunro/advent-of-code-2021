# frozen_string_literal: true

BASIC_ROTATION_MATRICES = [
  # rotate 90 deg about X
  Matrix[
    [1, 0, 0],
    [0, 0, -1],
    [0, 1, 0],
  ],
  # rotate 90 deg about Y
  Matrix[
    [0, 0, 1],
    [0, 1, 0],
    [-1, 0, 0],
  ],
  # rotate 90 deg about Z
  Matrix[
    [0, -1, 0],
    [1, 0, 0],
    [0, 0, 1],
  ],
].freeze

ROTATION_MATRICES = begin
  rotation_matrices = [Matrix.identity(3)]

  loop do
    current_length = rotation_matrices.length

    new_rotation_matrices = rotation_matrices
      .product(BASIC_ROTATION_MATRICES)
      .map { |matrix, basic_rotation| matrix * basic_rotation }

    rotation_matrices += new_rotation_matrices
    rotation_matrices = rotation_matrices.uniq

    break if current_length == rotation_matrices.length
  end

  rotation_matrices
end.freeze
