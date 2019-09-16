!-----------------------------------------------------------------------------!
! \file   src/example_backend.f90
! \brief  example_backend module
!-----------------------------------------------------------------------------!
module example_backend
  use iso_c_binding
  use flc_random, only : Engine
  implicit none

  integer, dimension(:), allocatable :: example_array

  type(Engine), private, save :: rng
contains

subroutine init(num_ints, seed)
  use, intrinsic :: ISO_C_BINDING
  implicit none
  integer, intent(in) :: num_ints
  integer(C_INT64_T), intent(in), optional :: seed
  integer(C_INT64_T) :: seedval = 12345_c_int64_t

  if (present(seed)) seedval = seed
    
  allocate(example_array(num_ints), source=0)
  rng = Engine(seedval)
end subroutine

subroutine randomize(min_int, max_int)
  use flc_random, only : uniform_int_distribution
  implicit none
  integer, intent(in) :: min_int
  integer, intent(in) :: max_int
  call uniform_int_distribution(min_int, max_int, rng, example_array)
end subroutine

subroutine sort()
  use flc_algorithm, only : flc_sort => sort
  implicit none

  call flc_sort(example_array)
end subroutine

subroutine shuffle()
  use flc_algorithm, only : flc_shuffle => shuffle
  implicit none

  call flc_shuffle(rng, example_array)
end subroutine

end module example_backend
!-----------------------------------------------------------------------------!
! end of src/example_backend.f90
!-----------------------------------------------------------------------------!
