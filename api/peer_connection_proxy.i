       
namespace std
{
  typedef long long unsigned int size_t;
  typedef long long int ptrdiff_t;
  typedef decltype(nullptr) nullptr_t;
}
namespace std
{
  inline namespace __cxx11 __attribute__((__abi_tag__ ("cxx11"))) { }
}
namespace __gnu_cxx
{
  inline namespace __cxx11 __attribute__((__abi_tag__ ("cxx11"))) { }
}
namespace std
{

  void
  __throw_bad_exception(void) __attribute__((__noreturn__));
  void
  __throw_bad_alloc(void) __attribute__((__noreturn__));
  void
  __throw_bad_cast(void) __attribute__((__noreturn__));
  void
  __throw_bad_typeid(void) __attribute__((__noreturn__));
  void
  __throw_logic_error(const char*) __attribute__((__noreturn__));
  void
  __throw_domain_error(const char*) __attribute__((__noreturn__));
  void
  __throw_invalid_argument(const char*) __attribute__((__noreturn__));
  void
  __throw_length_error(const char*) __attribute__((__noreturn__));
  void
  __throw_out_of_range(const char*) __attribute__((__noreturn__));
  void
  __throw_out_of_range_fmt(const char*, ...) __attribute__((__noreturn__))
    __attribute__((__format__(__gnu_printf__, 1, 2)));
  void
  __throw_runtime_error(const char*) __attribute__((__noreturn__));
  void
  __throw_range_error(const char*) __attribute__((__noreturn__));
  void
  __throw_overflow_error(const char*) __attribute__((__noreturn__));
  void
  __throw_underflow_error(const char*) __attribute__((__noreturn__));
  void
  __throw_ios_failure(const char*) __attribute__((__noreturn__));
  void
  __throw_system_error(int) __attribute__((__noreturn__));
  void
  __throw_future_error(int) __attribute__((__noreturn__));
  void
  __throw_bad_function_call() __attribute__((__noreturn__));

}
       
extern "C++" {
namespace std
{

  struct __true_type { };
  struct __false_type { };
  template<bool>
    struct __truth_type
    { typedef __false_type __type; };
  template<>
    struct __truth_type<true>
    { typedef __true_type __type; };
  template<class _Sp, class _Tp>
    struct __traitor
    {
      enum { __value = bool(_Sp::__value) || bool(_Tp::__value) };
      typedef typename __truth_type<__value>::__type __type;
    };
  template<typename, typename>
    struct __are_same
    {
      enum { __value = 0 };
      typedef __false_type __type;
    };
  template<typename _Tp>
    struct __are_same<_Tp, _Tp>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<typename _Tp>
    struct __is_void
    {
      enum { __value = 0 };
      typedef __false_type __type;
    };
  template<>
    struct __is_void<void>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<typename _Tp>
    struct __is_integer
    {
      enum { __value = 0 };
      typedef __false_type __type;
    };
  template<>
    struct __is_integer<bool>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<>
    struct __is_integer<char>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<>
    struct __is_integer<signed char>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<>
    struct __is_integer<unsigned char>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<>
    struct __is_integer<wchar_t>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<>
    struct __is_integer<char16_t>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<>
    struct __is_integer<char32_t>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<>
    struct __is_integer<short>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<>
    struct __is_integer<unsigned short>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<>
    struct __is_integer<int>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<>
    struct __is_integer<unsigned int>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<>
    struct __is_integer<long>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<>
    struct __is_integer<unsigned long>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<>
    struct __is_integer<long long>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<>
    struct __is_integer<unsigned long long>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
template<> struct __is_integer<__int128> { enum { __value = 1 }; typedef __true_type __type; }; template<> struct __is_integer<unsigned __int128> { enum { __value = 1 }; typedef __true_type __type; };
  template<typename _Tp>
    struct __is_floating
    {
      enum { __value = 0 };
      typedef __false_type __type;
    };
  template<>
    struct __is_floating<float>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<>
    struct __is_floating<double>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<>
    struct __is_floating<long double>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<typename _Tp>
    struct __is_pointer
    {
      enum { __value = 0 };
      typedef __false_type __type;
    };
  template<typename _Tp>
    struct __is_pointer<_Tp*>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<typename _Tp>
    struct __is_arithmetic
    : public __traitor<__is_integer<_Tp>, __is_floating<_Tp> >
    { };
  template<typename _Tp>
    struct __is_scalar
    : public __traitor<__is_arithmetic<_Tp>, __is_pointer<_Tp> >
    { };
  template<typename _Tp>
    struct __is_char
    {
      enum { __value = 0 };
      typedef __false_type __type;
    };
  template<>
    struct __is_char<char>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<>
    struct __is_char<wchar_t>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<typename _Tp>
    struct __is_byte
    {
      enum { __value = 0 };
      typedef __false_type __type;
    };
  template<>
    struct __is_byte<char>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<>
    struct __is_byte<signed char>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<>
    struct __is_byte<unsigned char>
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<typename _Tp>
    struct __is_move_iterator
    {
      enum { __value = 0 };
      typedef __false_type __type;
    };
  template<typename _Iterator>
    inline _Iterator
    __miter_base(_Iterator __it)
    { return __it; }

}
}
       
extern "C++" {
namespace __gnu_cxx
{

  template<bool, typename>
    struct __enable_if
    { };
  template<typename _Tp>
    struct __enable_if<true, _Tp>
    { typedef _Tp __type; };
  template<bool _Cond, typename _Iftrue, typename _Iffalse>
    struct __conditional_type
    { typedef _Iftrue __type; };
  template<typename _Iftrue, typename _Iffalse>
    struct __conditional_type<false, _Iftrue, _Iffalse>
    { typedef _Iffalse __type; };
  template<typename _Tp>
    struct __add_unsigned
    {
    private:
      typedef __enable_if<std::__is_integer<_Tp>::__value, _Tp> __if_type;
    public:
      typedef typename __if_type::__type __type;
    };
  template<>
    struct __add_unsigned<char>
    { typedef unsigned char __type; };
  template<>
    struct __add_unsigned<signed char>
    { typedef unsigned char __type; };
  template<>
    struct __add_unsigned<short>
    { typedef unsigned short __type; };
  template<>
    struct __add_unsigned<int>
    { typedef unsigned int __type; };
  template<>
    struct __add_unsigned<long>
    { typedef unsigned long __type; };
  template<>
    struct __add_unsigned<long long>
    { typedef unsigned long long __type; };
  template<>
    struct __add_unsigned<bool>;
  template<>
    struct __add_unsigned<wchar_t>;
  template<typename _Tp>
    struct __remove_unsigned
    {
    private:
      typedef __enable_if<std::__is_integer<_Tp>::__value, _Tp> __if_type;
    public:
      typedef typename __if_type::__type __type;
    };
  template<>
    struct __remove_unsigned<char>
    { typedef signed char __type; };
  template<>
    struct __remove_unsigned<unsigned char>
    { typedef signed char __type; };
  template<>
    struct __remove_unsigned<unsigned short>
    { typedef short __type; };
  template<>
    struct __remove_unsigned<unsigned int>
    { typedef int __type; };
  template<>
    struct __remove_unsigned<unsigned long>
    { typedef long __type; };
  template<>
    struct __remove_unsigned<unsigned long long>
    { typedef long long __type; };
  template<>
    struct __remove_unsigned<bool>;
  template<>
    struct __remove_unsigned<wchar_t>;
  template<typename _Type>
    inline bool
    __is_null_pointer(_Type* __ptr)
    { return __ptr == 0; }
  template<typename _Type>
    inline bool
    __is_null_pointer(_Type)
    { return false; }
  inline bool
  __is_null_pointer(std::nullptr_t)
  { return true; }
  template<typename _Tp, bool = std::__is_integer<_Tp>::__value>
    struct __promote
    { typedef double __type; };
  template<typename _Tp>
    struct __promote<_Tp, false>
    { };
  template<>
    struct __promote<long double>
    { typedef long double __type; };
  template<>
    struct __promote<double>
    { typedef double __type; };
  template<>
    struct __promote<float>
    { typedef float __type; };
  template<typename _Tp, typename _Up,
           typename _Tp2 = typename __promote<_Tp>::__type,
           typename _Up2 = typename __promote<_Up>::__type>
    struct __promote_2
    {
      typedef __typeof__(_Tp2() + _Up2()) __type;
    };
  template<typename _Tp, typename _Up, typename _Vp,
           typename _Tp2 = typename __promote<_Tp>::__type,
           typename _Up2 = typename __promote<_Up>::__type,
           typename _Vp2 = typename __promote<_Vp>::__type>
    struct __promote_3
    {
      typedef __typeof__(_Tp2() + _Up2() + _Vp2()) __type;
    };
  template<typename _Tp, typename _Up, typename _Vp, typename _Wp,
           typename _Tp2 = typename __promote<_Tp>::__type,
           typename _Up2 = typename __promote<_Up>::__type,
           typename _Vp2 = typename __promote<_Vp>::__type,
           typename _Wp2 = typename __promote<_Wp>::__type>
    struct __promote_4
    {
      typedef __typeof__(_Tp2() + _Up2() + _Vp2() + _Wp2()) __type;
    };

}
}
       
namespace __gnu_cxx
{

  template<typename _Value>
    struct __numeric_traits_integer
    {
      static const _Value __min = (((_Value)(-1) < 0) ? (_Value)1 << (sizeof(_Value) * 8 - ((_Value)(-1) < 0)) : (_Value)0);
      static const _Value __max = (((_Value)(-1) < 0) ? (((((_Value)1 << ((sizeof(_Value) * 8 - ((_Value)(-1) < 0)) - 1)) - 1) << 1) + 1) : ~(_Value)0);
      static const bool __is_signed = ((_Value)(-1) < 0);
      static const int __digits = (sizeof(_Value) * 8 - ((_Value)(-1) < 0));
    };
  template<typename _Value>
    const _Value __numeric_traits_integer<_Value>::__min;
  template<typename _Value>
    const _Value __numeric_traits_integer<_Value>::__max;
  template<typename _Value>
    const bool __numeric_traits_integer<_Value>::__is_signed;
  template<typename _Value>
    const int __numeric_traits_integer<_Value>::__digits;
  template<typename _Value>
    struct __numeric_traits_floating
    {
      static const int __max_digits10 = (2 + (std::__are_same<_Value, float>::__value ? 24 : std::__are_same<_Value, double>::__value ? 53 : 64) * 643L / 2136);
      static const bool __is_signed = true;
      static const int __digits10 = (std::__are_same<_Value, float>::__value ? 6 : std::__are_same<_Value, double>::__value ? 15 : 18);
      static const int __max_exponent10 = (std::__are_same<_Value, float>::__value ? 38 : std::__are_same<_Value, double>::__value ? 308 : 4932);
    };
  template<typename _Value>
    const int __numeric_traits_floating<_Value>::__max_digits10;
  template<typename _Value>
    const bool __numeric_traits_floating<_Value>::__is_signed;
  template<typename _Value>
    const int __numeric_traits_floating<_Value>::__digits10;
  template<typename _Value>
    const int __numeric_traits_floating<_Value>::__max_exponent10;
  template<typename _Value>
    struct __numeric_traits
    : public __conditional_type<std::__is_integer<_Value>::__value,
    __numeric_traits_integer<_Value>,
    __numeric_traits_floating<_Value> >::__type
    { };

}
       
namespace std
{

  template<typename _Tp>
    inline constexpr _Tp*
    __addressof(_Tp& __r) noexcept
    { return __builtin_addressof(__r); }

}
       
namespace std
{
  typedef short unsigned int uint_least16_t;
  typedef unsigned int uint_least32_t;
}
namespace std
{

  template<typename _Tp, _Tp __v>
    struct integral_constant
    {
      static constexpr _Tp value = __v;
      typedef _Tp value_type;
      typedef integral_constant<_Tp, __v> type;
      constexpr operator value_type() const noexcept { return value; }
      constexpr value_type operator()() const noexcept { return value; }
    };
  template<typename _Tp, _Tp __v>
    constexpr _Tp integral_constant<_Tp, __v>::value;
  typedef integral_constant<bool, true> true_type;
  typedef integral_constant<bool, false> false_type;
  template<bool __v>
    using __bool_constant = integral_constant<bool, __v>;
  template<bool, typename, typename>
    struct conditional;
  template<typename...>
    struct __or_;
  template<>
    struct __or_<>
    : public false_type
    { };
  template<typename _B1>
    struct __or_<_B1>
    : public _B1
    { };
  template<typename _B1, typename _B2>
    struct __or_<_B1, _B2>
    : public conditional<_B1::value, _B1, _B2>::type
    { };
  template<typename _B1, typename _B2, typename _B3, typename... _Bn>
    struct __or_<_B1, _B2, _B3, _Bn...>
    : public conditional<_B1::value, _B1, __or_<_B2, _B3, _Bn...>>::type
    { };
  template<typename...>
    struct __and_;
  template<>
    struct __and_<>
    : public true_type
    { };
  template<typename _B1>
    struct __and_<_B1>
    : public _B1
    { };
  template<typename _B1, typename _B2>
    struct __and_<_B1, _B2>
    : public conditional<_B1::value, _B2, _B1>::type
    { };
  template<typename _B1, typename _B2, typename _B3, typename... _Bn>
    struct __and_<_B1, _B2, _B3, _Bn...>
    : public conditional<_B1::value, __and_<_B2, _B3, _Bn...>, _B1>::type
    { };
  template<typename _Pp>
    struct __not_
    : public __bool_constant<!bool(_Pp::value)>
    { };
  template<typename _Tp>
    struct __success_type
    { typedef _Tp type; };
  struct __failure_type
  { };
  template<typename>
    struct remove_cv;
  template<typename>
    struct __is_void_helper
    : public false_type { };
  template<>
    struct __is_void_helper<void>
    : public true_type { };
  template<typename _Tp>
    struct is_void
    : public __is_void_helper<typename remove_cv<_Tp>::type>::type
    { };
  template<typename>
    struct __is_integral_helper
    : public false_type { };
  template<>
    struct __is_integral_helper<bool>
    : public true_type { };
  template<>
    struct __is_integral_helper<char>
    : public true_type { };
  template<>
    struct __is_integral_helper<signed char>
    : public true_type { };
  template<>
    struct __is_integral_helper<unsigned char>
    : public true_type { };
  template<>
    struct __is_integral_helper<wchar_t>
    : public true_type { };
  template<>
    struct __is_integral_helper<char16_t>
    : public true_type { };
  template<>
    struct __is_integral_helper<char32_t>
    : public true_type { };
  template<>
    struct __is_integral_helper<short>
    : public true_type { };
  template<>
    struct __is_integral_helper<unsigned short>
    : public true_type { };
  template<>
    struct __is_integral_helper<int>
    : public true_type { };
  template<>
    struct __is_integral_helper<unsigned int>
    : public true_type { };
  template<>
    struct __is_integral_helper<long>
    : public true_type { };
  template<>
    struct __is_integral_helper<unsigned long>
    : public true_type { };
  template<>
    struct __is_integral_helper<long long>
    : public true_type { };
  template<>
    struct __is_integral_helper<unsigned long long>
    : public true_type { };
  template<>
    struct __is_integral_helper<__int128>
    : public true_type { };
  template<>
    struct __is_integral_helper<unsigned __int128>
    : public true_type { };
  template<typename _Tp>
    struct is_integral
    : public __is_integral_helper<typename remove_cv<_Tp>::type>::type
    { };
  template<typename>
    struct __is_floating_point_helper
    : public false_type { };
  template<>
    struct __is_floating_point_helper<float>
    : public true_type { };
  template<>
    struct __is_floating_point_helper<double>
    : public true_type { };
  template<>
    struct __is_floating_point_helper<long double>
    : public true_type { };
  template<>
    struct __is_floating_point_helper<__float128>
    : public true_type { };
  template<typename _Tp>
    struct is_floating_point
    : public __is_floating_point_helper<typename remove_cv<_Tp>::type>::type
    { };
  template<typename>
    struct is_array
    : public false_type { };
  template<typename _Tp, std::size_t _Size>
    struct is_array<_Tp[_Size]>
    : public true_type { };
  template<typename _Tp>
    struct is_array<_Tp[]>
    : public true_type { };
  template<typename>
    struct __is_pointer_helper
    : public false_type { };
  template<typename _Tp>
    struct __is_pointer_helper<_Tp*>
    : public true_type { };
  template<typename _Tp>
    struct is_pointer
    : public __is_pointer_helper<typename remove_cv<_Tp>::type>::type
    { };
  template<typename>
    struct is_lvalue_reference
    : public false_type { };
  template<typename _Tp>
    struct is_lvalue_reference<_Tp&>
    : public true_type { };
  template<typename>
    struct is_rvalue_reference
    : public false_type { };
  template<typename _Tp>
    struct is_rvalue_reference<_Tp&&>
    : public true_type { };
  template<typename>
    struct is_function;
  template<typename>
    struct __is_member_object_pointer_helper
    : public false_type { };
  template<typename _Tp, typename _Cp>
    struct __is_member_object_pointer_helper<_Tp _Cp::*>
    : public integral_constant<bool, !is_function<_Tp>::value> { };
  template<typename _Tp>
    struct is_member_object_pointer
    : public __is_member_object_pointer_helper<
    typename remove_cv<_Tp>::type>::type
    { };
  template<typename>
    struct __is_member_function_pointer_helper
    : public false_type { };
  template<typename _Tp, typename _Cp>
    struct __is_member_function_pointer_helper<_Tp _Cp::*>
    : public integral_constant<bool, is_function<_Tp>::value> { };
  template<typename _Tp>
    struct is_member_function_pointer
    : public __is_member_function_pointer_helper<
    typename remove_cv<_Tp>::type>::type
    { };
  template<typename _Tp>
    struct is_enum
    : public integral_constant<bool, __is_enum(_Tp)>
    { };
  template<typename _Tp>
    struct is_union
    : public integral_constant<bool, __is_union(_Tp)>
    { };
  template<typename _Tp>
    struct is_class
    : public integral_constant<bool, __is_class(_Tp)>
    { };
  template<typename>
    struct is_function
    : public false_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes...) >
    : public true_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes...) & >
    : public true_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes...) && >
    : public true_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes......) >
    : public true_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes......) & >
    : public true_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes......) && >
    : public true_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes...) const >
    : public true_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes...) const & >
    : public true_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes...) const && >
    : public true_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes......) const >
    : public true_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes......) const & >
    : public true_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes......) const && >
    : public true_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes...) volatile >
    : public true_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes...) volatile & >
    : public true_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes...) volatile && >
    : public true_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes......) volatile >
    : public true_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes......) volatile & >
    : public true_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes......) volatile && >
    : public true_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes...) const volatile >
    : public true_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes...) const volatile & >
    : public true_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes...) const volatile && >
    : public true_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes......) const volatile >
    : public true_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes......) const volatile & >
    : public true_type { };
  template<typename _Res, typename... _ArgTypes >
    struct is_function<_Res(_ArgTypes......) const volatile && >
    : public true_type { };
  template<typename>
    struct __is_null_pointer_helper
    : public false_type { };
  template<>
    struct __is_null_pointer_helper<std::nullptr_t>
    : public true_type { };
  template<typename _Tp>
    struct is_null_pointer
    : public __is_null_pointer_helper<typename remove_cv<_Tp>::type>::type
    { };
  template<typename _Tp>
    struct __is_nullptr_t
    : public is_null_pointer<_Tp>
    { };
  template<typename _Tp>
    struct is_reference
    : public __or_<is_lvalue_reference<_Tp>,
                   is_rvalue_reference<_Tp>>::type
    { };
  template<typename _Tp>
    struct is_arithmetic
    : public __or_<is_integral<_Tp>, is_floating_point<_Tp>>::type
    { };
  template<typename _Tp>
    struct is_fundamental
    : public __or_<is_arithmetic<_Tp>, is_void<_Tp>,
     is_null_pointer<_Tp>>::type
    { };
  template<typename _Tp>
    struct is_object
    : public __not_<__or_<is_function<_Tp>, is_reference<_Tp>,
                          is_void<_Tp>>>::type
    { };
  template<typename>
    struct is_member_pointer;
  template<typename _Tp>
    struct is_scalar
    : public __or_<is_arithmetic<_Tp>, is_enum<_Tp>, is_pointer<_Tp>,
                   is_member_pointer<_Tp>, is_null_pointer<_Tp>>::type
    { };
  template<typename _Tp>
    struct is_compound
    : public integral_constant<bool, !is_fundamental<_Tp>::value> { };
  template<typename _Tp>
    struct __is_member_pointer_helper
    : public false_type { };
  template<typename _Tp, typename _Cp>
    struct __is_member_pointer_helper<_Tp _Cp::*>
    : public true_type { };
  template<typename _Tp>
    struct is_member_pointer
    : public __is_member_pointer_helper<typename remove_cv<_Tp>::type>::type
    { };
  template<typename _Tp>
    struct __is_referenceable
    : public __or_<is_object<_Tp>, is_reference<_Tp>>::type
    { };
  template<typename _Res, typename... _Args >
    struct __is_referenceable<_Res(_Args...) >
    : public true_type
    { };
  template<typename _Res, typename... _Args >
    struct __is_referenceable<_Res(_Args......) >
    : public true_type
    { };
  template<typename>
    struct is_const
    : public false_type { };
  template<typename _Tp>
    struct is_const<_Tp const>
    : public true_type { };
  template<typename>
    struct is_volatile
    : public false_type { };
  template<typename _Tp>
    struct is_volatile<_Tp volatile>
    : public true_type { };
  template<typename _Tp>
    struct is_trivial
    : public integral_constant<bool, __is_trivial(_Tp)>
    { };
  template<typename _Tp>
    struct is_trivially_copyable
    : public integral_constant<bool, __is_trivially_copyable(_Tp)>
    { };
  template<typename _Tp>
    struct is_standard_layout
    : public integral_constant<bool, __is_standard_layout(_Tp)>
    { };
  template<typename _Tp>
    struct is_pod
    : public integral_constant<bool, __is_pod(_Tp)>
    { };
  template<typename _Tp>
    struct is_literal_type
    : public integral_constant<bool, __is_literal_type(_Tp)>
    { };
  template<typename _Tp>
    struct is_empty
    : public integral_constant<bool, __is_empty(_Tp)>
    { };
  template<typename _Tp>
    struct is_polymorphic
    : public integral_constant<bool, __is_polymorphic(_Tp)>
    { };
  template<typename _Tp>
    struct is_final
    : public integral_constant<bool, __is_final(_Tp)>
    { };
  template<typename _Tp>
    struct is_abstract
    : public integral_constant<bool, __is_abstract(_Tp)>
    { };
  template<typename _Tp,
    bool = is_arithmetic<_Tp>::value>
    struct __is_signed_helper
    : public false_type { };
  template<typename _Tp>
    struct __is_signed_helper<_Tp, true>
    : public integral_constant<bool, _Tp(-1) < _Tp(0)>
    { };
  template<typename _Tp>
    struct is_signed
    : public __is_signed_helper<_Tp>::type
    { };
  template<typename _Tp>
    struct is_unsigned
    : public __and_<is_arithmetic<_Tp>, __not_<is_signed<_Tp>>>
    { };
  template<typename _Tp, typename _Up = _Tp&&>
    _Up
    __declval(int);
  template<typename _Tp>
    _Tp
    __declval(long);
  template<typename _Tp>
    auto declval() noexcept -> decltype(__declval<_Tp>(0));
  template<typename, unsigned = 0>
    struct extent;
  template<typename>
    struct remove_all_extents;
  template<typename _Tp>
    struct __is_array_known_bounds
    : public integral_constant<bool, (extent<_Tp>::value > 0)>
    { };
  template<typename _Tp>
    struct __is_array_unknown_bounds
    : public __and_<is_array<_Tp>, __not_<extent<_Tp>>>
    { };
  struct __do_is_destructible_impl
  {
    template<typename _Tp, typename = decltype(declval<_Tp&>().~_Tp())>
      static true_type __test(int);
    template<typename>
      static false_type __test(...);
  };
  template<typename _Tp>
    struct __is_destructible_impl
    : public __do_is_destructible_impl
    {
      typedef decltype(__test<_Tp>(0)) type;
    };
  template<typename _Tp,
           bool = __or_<is_void<_Tp>,
                        __is_array_unknown_bounds<_Tp>,
                        is_function<_Tp>>::value,
           bool = __or_<is_reference<_Tp>, is_scalar<_Tp>>::value>
    struct __is_destructible_safe;
  template<typename _Tp>
    struct __is_destructible_safe<_Tp, false, false>
    : public __is_destructible_impl<typename
               remove_all_extents<_Tp>::type>::type
    { };
  template<typename _Tp>
    struct __is_destructible_safe<_Tp, true, false>
    : public false_type { };
  template<typename _Tp>
    struct __is_destructible_safe<_Tp, false, true>
    : public true_type { };
  template<typename _Tp>
    struct is_destructible
    : public __is_destructible_safe<_Tp>::type
    { };
  struct __do_is_nt_destructible_impl
  {
    template<typename _Tp>
      static integral_constant<bool, noexcept(declval<_Tp&>().~_Tp())>
        __test(int);
    template<typename>
      static false_type __test(...);
  };
  template<typename _Tp>
    struct __is_nt_destructible_impl
    : public __do_is_nt_destructible_impl
    {
      typedef decltype(__test<_Tp>(0)) type;
    };
  template<typename _Tp,
           bool = __or_<is_void<_Tp>,
                        __is_array_unknown_bounds<_Tp>,
                        is_function<_Tp>>::value,
           bool = __or_<is_reference<_Tp>, is_scalar<_Tp>>::value>
    struct __is_nt_destructible_safe;
  template<typename _Tp>
    struct __is_nt_destructible_safe<_Tp, false, false>
    : public __is_nt_destructible_impl<typename
               remove_all_extents<_Tp>::type>::type
    { };
  template<typename _Tp>
    struct __is_nt_destructible_safe<_Tp, true, false>
    : public false_type { };
  template<typename _Tp>
    struct __is_nt_destructible_safe<_Tp, false, true>
    : public true_type { };
  template<typename _Tp>
    struct is_nothrow_destructible
    : public __is_nt_destructible_safe<_Tp>::type
    { };
  struct __do_is_default_constructible_impl
  {
    template<typename _Tp, typename = decltype(_Tp())>
      static true_type __test(int);
    template<typename>
      static false_type __test(...);
  };
  template<typename _Tp>
    struct __is_default_constructible_impl
    : public __do_is_default_constructible_impl
    {
      typedef decltype(__test<_Tp>(0)) type;
    };
  template<typename _Tp>
    struct __is_default_constructible_atom
    : public __and_<__not_<is_void<_Tp>>,
                    __is_default_constructible_impl<_Tp>>
    { };
  template<typename _Tp, bool = is_array<_Tp>::value>
    struct __is_default_constructible_safe;
  template<typename _Tp>
    struct __is_default_constructible_safe<_Tp, true>
    : public __and_<__is_array_known_bounds<_Tp>,
      __is_default_constructible_atom<typename
                      remove_all_extents<_Tp>::type>>
    { };
  template<typename _Tp>
    struct __is_default_constructible_safe<_Tp, false>
    : public __is_default_constructible_atom<_Tp>::type
    { };
  template<typename _Tp>
    struct is_default_constructible
    : public __is_default_constructible_safe<_Tp>::type
    { };
  template<typename _Tp, typename... _Args>
    struct is_constructible
      : public __bool_constant<__is_constructible(_Tp, _Args...)>
    { };
  template<typename _Tp, bool = __is_referenceable<_Tp>::value>
    struct __is_copy_constructible_impl;
  template<typename _Tp>
    struct __is_copy_constructible_impl<_Tp, false>
    : public false_type { };
  template<typename _Tp>
    struct __is_copy_constructible_impl<_Tp, true>
    : public is_constructible<_Tp, const _Tp&>
    { };
  template<typename _Tp>
    struct is_copy_constructible
    : public __is_copy_constructible_impl<_Tp>
    { };
  template<typename _Tp, bool = __is_referenceable<_Tp>::value>
    struct __is_move_constructible_impl;
  template<typename _Tp>
    struct __is_move_constructible_impl<_Tp, false>
    : public false_type { };
  template<typename _Tp>
    struct __is_move_constructible_impl<_Tp, true>
    : public is_constructible<_Tp, _Tp&&>
    { };
  template<typename _Tp>
    struct is_move_constructible
    : public __is_move_constructible_impl<_Tp>
    { };
  template<typename _Tp>
    struct __is_nt_default_constructible_atom
    : public integral_constant<bool, noexcept(_Tp())>
    { };
  template<typename _Tp, bool = is_array<_Tp>::value>
    struct __is_nt_default_constructible_impl;
  template<typename _Tp>
    struct __is_nt_default_constructible_impl<_Tp, true>
    : public __and_<__is_array_known_bounds<_Tp>,
      __is_nt_default_constructible_atom<typename
                      remove_all_extents<_Tp>::type>>
    { };
  template<typename _Tp>
    struct __is_nt_default_constructible_impl<_Tp, false>
    : public __is_nt_default_constructible_atom<_Tp>
    { };
  template<typename _Tp>
    struct is_nothrow_default_constructible
    : public __and_<is_default_constructible<_Tp>,
                    __is_nt_default_constructible_impl<_Tp>>
    { };
  template<typename _Tp, typename... _Args>
    struct __is_nt_constructible_impl
    : public integral_constant<bool, noexcept(_Tp(declval<_Args>()...))>
    { };
  template<typename _Tp, typename _Arg>
    struct __is_nt_constructible_impl<_Tp, _Arg>
    : public integral_constant<bool,
                               noexcept(static_cast<_Tp>(declval<_Arg>()))>
    { };
  template<typename _Tp>
    struct __is_nt_constructible_impl<_Tp>
    : public is_nothrow_default_constructible<_Tp>
    { };
  template<typename _Tp, typename... _Args>
    struct is_nothrow_constructible
    : public __and_<is_constructible<_Tp, _Args...>,
      __is_nt_constructible_impl<_Tp, _Args...>>
    { };
  template<typename _Tp, bool = __is_referenceable<_Tp>::value>
    struct __is_nothrow_copy_constructible_impl;
  template<typename _Tp>
    struct __is_nothrow_copy_constructible_impl<_Tp, false>
    : public false_type { };
  template<typename _Tp>
    struct __is_nothrow_copy_constructible_impl<_Tp, true>
    : public is_nothrow_constructible<_Tp, const _Tp&>
    { };
  template<typename _Tp>
    struct is_nothrow_copy_constructible
    : public __is_nothrow_copy_constructible_impl<_Tp>
    { };
  template<typename _Tp, bool = __is_referenceable<_Tp>::value>
    struct __is_nothrow_move_constructible_impl;
  template<typename _Tp>
    struct __is_nothrow_move_constructible_impl<_Tp, false>
    : public false_type { };
  template<typename _Tp>
    struct __is_nothrow_move_constructible_impl<_Tp, true>
    : public is_nothrow_constructible<_Tp, _Tp&&>
    { };
  template<typename _Tp>
    struct is_nothrow_move_constructible
    : public __is_nothrow_move_constructible_impl<_Tp>
    { };
  template<typename _Tp, typename _Up>
    struct is_assignable
      : public __bool_constant<__is_assignable(_Tp, _Up)>
    { };
  template<typename _Tp, bool = __is_referenceable<_Tp>::value>
    struct __is_copy_assignable_impl;
  template<typename _Tp>
    struct __is_copy_assignable_impl<_Tp, false>
    : public false_type { };
  template<typename _Tp>
    struct __is_copy_assignable_impl<_Tp, true>
    : public is_assignable<_Tp&, const _Tp&>
    { };
  template<typename _Tp>
    struct is_copy_assignable
    : public __is_copy_assignable_impl<_Tp>
    { };
  template<typename _Tp, bool = __is_referenceable<_Tp>::value>
    struct __is_move_assignable_impl;
  template<typename _Tp>
    struct __is_move_assignable_impl<_Tp, false>
    : public false_type { };
  template<typename _Tp>
    struct __is_move_assignable_impl<_Tp, true>
    : public is_assignable<_Tp&, _Tp&&>
    { };
  template<typename _Tp>
    struct is_move_assignable
    : public __is_move_assignable_impl<_Tp>
    { };
  template<typename _Tp, typename _Up>
    struct __is_nt_assignable_impl
    : public integral_constant<bool, noexcept(declval<_Tp>() = declval<_Up>())>
    { };
  template<typename _Tp, typename _Up>
    struct is_nothrow_assignable
    : public __and_<is_assignable<_Tp, _Up>,
      __is_nt_assignable_impl<_Tp, _Up>>
    { };
  template<typename _Tp, bool = __is_referenceable<_Tp>::value>
    struct __is_nt_copy_assignable_impl;
  template<typename _Tp>
    struct __is_nt_copy_assignable_impl<_Tp, false>
    : public false_type { };
  template<typename _Tp>
    struct __is_nt_copy_assignable_impl<_Tp, true>
    : public is_nothrow_assignable<_Tp&, const _Tp&>
    { };
  template<typename _Tp>
    struct is_nothrow_copy_assignable
    : public __is_nt_copy_assignable_impl<_Tp>
    { };
  template<typename _Tp, bool = __is_referenceable<_Tp>::value>
    struct __is_nt_move_assignable_impl;
  template<typename _Tp>
    struct __is_nt_move_assignable_impl<_Tp, false>
    : public false_type { };
  template<typename _Tp>
    struct __is_nt_move_assignable_impl<_Tp, true>
    : public is_nothrow_assignable<_Tp&, _Tp&&>
    { };
  template<typename _Tp>
    struct is_nothrow_move_assignable
    : public __is_nt_move_assignable_impl<_Tp>
    { };
  template<typename _Tp, typename... _Args>
    struct is_trivially_constructible
    : public __bool_constant<__is_trivially_constructible(_Tp, _Args...)>
    { };
  template<typename _Tp>
    struct is_trivially_default_constructible
    : public is_trivially_constructible<_Tp>::type
    { };
  struct __do_is_implicitly_default_constructible_impl
  {
    template <typename _Tp>
    static void __helper(const _Tp&);
    template <typename _Tp>
    static true_type __test(const _Tp&,
                            decltype(__helper<const _Tp&>({}))* = 0);
    static false_type __test(...);
  };
  template<typename _Tp>
    struct __is_implicitly_default_constructible_impl
      : public __do_is_implicitly_default_constructible_impl
  {
    typedef decltype(__test(declval<_Tp>())) type;
  };
  template<typename _Tp>
    struct __is_implicitly_default_constructible_safe
      : public __is_implicitly_default_constructible_impl<_Tp>::type
  { };
  template <typename _Tp>
    struct __is_implicitly_default_constructible
      : public __and_<is_default_constructible<_Tp>,
                      __is_implicitly_default_constructible_safe<_Tp>>
  { };
  template<typename _Tp, bool = __is_referenceable<_Tp>::value>
    struct __is_trivially_copy_constructible_impl;
  template<typename _Tp>
    struct __is_trivially_copy_constructible_impl<_Tp, false>
    : public false_type { };
  template<typename _Tp>
    struct __is_trivially_copy_constructible_impl<_Tp, true>
    : public __and_<is_copy_constructible<_Tp>,
      integral_constant<bool,
   __is_trivially_constructible(_Tp, const _Tp&)>>
    { };
  template<typename _Tp>
    struct is_trivially_copy_constructible
    : public __is_trivially_copy_constructible_impl<_Tp>
    { };
  template<typename _Tp, bool = __is_referenceable<_Tp>::value>
    struct __is_trivially_move_constructible_impl;
  template<typename _Tp>
    struct __is_trivially_move_constructible_impl<_Tp, false>
    : public false_type { };
  template<typename _Tp>
    struct __is_trivially_move_constructible_impl<_Tp, true>
    : public __and_<is_move_constructible<_Tp>,
      integral_constant<bool,
   __is_trivially_constructible(_Tp, _Tp&&)>>
    { };
  template<typename _Tp>
    struct is_trivially_move_constructible
    : public __is_trivially_move_constructible_impl<_Tp>
    { };
  template<typename _Tp, typename _Up>
    struct is_trivially_assignable
    : public __bool_constant<__is_trivially_assignable(_Tp, _Up)>
    { };
  template<typename _Tp, bool = __is_referenceable<_Tp>::value>
    struct __is_trivially_copy_assignable_impl;
  template<typename _Tp>
    struct __is_trivially_copy_assignable_impl<_Tp, false>
    : public false_type { };
  template<typename _Tp>
    struct __is_trivially_copy_assignable_impl<_Tp, true>
    : public __and_<is_copy_assignable<_Tp>,
      integral_constant<bool,
   __is_trivially_assignable(_Tp&, const _Tp&)>>
    { };
  template<typename _Tp>
    struct is_trivially_copy_assignable
    : public __is_trivially_copy_assignable_impl<_Tp>
    { };
  template<typename _Tp, bool = __is_referenceable<_Tp>::value>
    struct __is_trivially_move_assignable_impl;
  template<typename _Tp>
    struct __is_trivially_move_assignable_impl<_Tp, false>
    : public false_type { };
  template<typename _Tp>
    struct __is_trivially_move_assignable_impl<_Tp, true>
    : public __and_<is_move_assignable<_Tp>,
      integral_constant<bool,
   __is_trivially_assignable(_Tp&, _Tp&&)>>
    { };
  template<typename _Tp>
    struct is_trivially_move_assignable
    : public __is_trivially_move_assignable_impl<_Tp>
    { };
  template<typename _Tp>
    struct is_trivially_destructible
    : public __and_<is_destructible<_Tp>, integral_constant<bool,
         __has_trivial_destructor(_Tp)>>
    { };
  template<typename _Tp>
    struct has_virtual_destructor
    : public integral_constant<bool, __has_virtual_destructor(_Tp)>
    { };
  template<typename _Tp>
    struct alignment_of
    : public integral_constant<std::size_t, __alignof__(_Tp)> { };
  template<typename>
    struct rank
    : public integral_constant<std::size_t, 0> { };
  template<typename _Tp, std::size_t _Size>
    struct rank<_Tp[_Size]>
    : public integral_constant<std::size_t, 1 + rank<_Tp>::value> { };
  template<typename _Tp>
    struct rank<_Tp[]>
    : public integral_constant<std::size_t, 1 + rank<_Tp>::value> { };
  template<typename, unsigned _Uint>
    struct extent
    : public integral_constant<std::size_t, 0> { };
  template<typename _Tp, unsigned _Uint, std::size_t _Size>
    struct extent<_Tp[_Size], _Uint>
    : public integral_constant<std::size_t,
          _Uint == 0 ? _Size : extent<_Tp,
          _Uint - 1>::value>
    { };
  template<typename _Tp, unsigned _Uint>
    struct extent<_Tp[], _Uint>
    : public integral_constant<std::size_t,
          _Uint == 0 ? 0 : extent<_Tp,
             _Uint - 1>::value>
    { };
  template<typename, typename>
    struct is_same
    : public false_type { };
  template<typename _Tp>
    struct is_same<_Tp, _Tp>
    : public true_type { };
  template<typename _Base, typename _Derived>
    struct is_base_of
    : public integral_constant<bool, __is_base_of(_Base, _Derived)>
    { };
  template<typename _From, typename _To,
           bool = __or_<is_void<_From>, is_function<_To>,
                        is_array<_To>>::value>
    struct __is_convertible_helper
    { typedef typename is_void<_To>::type type; };
  template<typename _From, typename _To>
    class __is_convertible_helper<_From, _To, false>
    {
       template<typename _To1>
 static void __test_aux(_To1);
      template<typename _From1, typename _To1,
        typename = decltype(__test_aux<_To1>(std::declval<_From1>()))>
 static true_type
 __test(int);
      template<typename, typename>
 static false_type
 __test(...);
    public:
      typedef decltype(__test<_From, _To>(0)) type;
    };
  template<typename _From, typename _To>
    struct is_convertible
    : public __is_convertible_helper<_From, _To>::type
    { };
  template<typename _Tp>
    struct remove_const
    { typedef _Tp type; };
  template<typename _Tp>
    struct remove_const<_Tp const>
    { typedef _Tp type; };
  template<typename _Tp>
    struct remove_volatile
    { typedef _Tp type; };
  template<typename _Tp>
    struct remove_volatile<_Tp volatile>
    { typedef _Tp type; };
  template<typename _Tp>
    struct remove_cv
    {
      typedef typename
      remove_const<typename remove_volatile<_Tp>::type>::type type;
    };
  template<typename _Tp>
    struct add_const
    { typedef _Tp const type; };
  template<typename _Tp>
    struct add_volatile
    { typedef _Tp volatile type; };
  template<typename _Tp>
    struct add_cv
    {
      typedef typename
      add_const<typename add_volatile<_Tp>::type>::type type;
    };
  template<typename _Tp>
    using remove_const_t = typename remove_const<_Tp>::type;
  template<typename _Tp>
    using remove_volatile_t = typename remove_volatile<_Tp>::type;
  template<typename _Tp>
    using remove_cv_t = typename remove_cv<_Tp>::type;
  template<typename _Tp>
    using add_const_t = typename add_const<_Tp>::type;
  template<typename _Tp>
    using add_volatile_t = typename add_volatile<_Tp>::type;
  template<typename _Tp>
    using add_cv_t = typename add_cv<_Tp>::type;
  template<typename _Tp>
    struct remove_reference
    { typedef _Tp type; };
  template<typename _Tp>
    struct remove_reference<_Tp&>
    { typedef _Tp type; };
  template<typename _Tp>
    struct remove_reference<_Tp&&>
    { typedef _Tp type; };
  template<typename _Tp, bool = __is_referenceable<_Tp>::value>
    struct __add_lvalue_reference_helper
    { typedef _Tp type; };
  template<typename _Tp>
    struct __add_lvalue_reference_helper<_Tp, true>
    { typedef _Tp& type; };
  template<typename _Tp>
    struct add_lvalue_reference
    : public __add_lvalue_reference_helper<_Tp>
    { };
  template<typename _Tp, bool = __is_referenceable<_Tp>::value>
    struct __add_rvalue_reference_helper
    { typedef _Tp type; };
  template<typename _Tp>
    struct __add_rvalue_reference_helper<_Tp, true>
    { typedef _Tp&& type; };
  template<typename _Tp>
    struct add_rvalue_reference
    : public __add_rvalue_reference_helper<_Tp>
    { };
  template<typename _Tp>
    using remove_reference_t = typename remove_reference<_Tp>::type;
  template<typename _Tp>
    using add_lvalue_reference_t = typename add_lvalue_reference<_Tp>::type;
  template<typename _Tp>
    using add_rvalue_reference_t = typename add_rvalue_reference<_Tp>::type;
  template<typename _Unqualified, bool _IsConst, bool _IsVol>
    struct __cv_selector;
  template<typename _Unqualified>
    struct __cv_selector<_Unqualified, false, false>
    { typedef _Unqualified __type; };
  template<typename _Unqualified>
    struct __cv_selector<_Unqualified, false, true>
    { typedef volatile _Unqualified __type; };
  template<typename _Unqualified>
    struct __cv_selector<_Unqualified, true, false>
    { typedef const _Unqualified __type; };
  template<typename _Unqualified>
    struct __cv_selector<_Unqualified, true, true>
    { typedef const volatile _Unqualified __type; };
  template<typename _Qualified, typename _Unqualified,
    bool _IsConst = is_const<_Qualified>::value,
    bool _IsVol = is_volatile<_Qualified>::value>
    class __match_cv_qualifiers
    {
      typedef __cv_selector<_Unqualified, _IsConst, _IsVol> __match;
    public:
      typedef typename __match::__type __type;
    };
  template<typename _Tp>
    struct __make_unsigned
    { typedef _Tp __type; };
  template<>
    struct __make_unsigned<char>
    { typedef unsigned char __type; };
  template<>
    struct __make_unsigned<signed char>
    { typedef unsigned char __type; };
  template<>
    struct __make_unsigned<short>
    { typedef unsigned short __type; };
  template<>
    struct __make_unsigned<int>
    { typedef unsigned int __type; };
  template<>
    struct __make_unsigned<long>
    { typedef unsigned long __type; };
  template<>
    struct __make_unsigned<long long>
    { typedef unsigned long long __type; };
  template<>
    struct __make_unsigned<__int128>
    { typedef unsigned __int128 __type; };
  template<typename _Tp,
    bool _IsInt = is_integral<_Tp>::value,
    bool _IsEnum = is_enum<_Tp>::value>
    class __make_unsigned_selector;
  template<typename _Tp>
    class __make_unsigned_selector<_Tp, true, false>
    {
      typedef __make_unsigned<typename remove_cv<_Tp>::type> __unsignedt;
      typedef typename __unsignedt::__type __unsigned_type;
      typedef __match_cv_qualifiers<_Tp, __unsigned_type> __cv_unsigned;
    public:
      typedef typename __cv_unsigned::__type __type;
    };
  template<typename _Tp>
    class __make_unsigned_selector<_Tp, false, true>
    {
      typedef unsigned char __smallest;
      static const bool __b0 = sizeof(_Tp) <= sizeof(__smallest);
      static const bool __b1 = sizeof(_Tp) <= sizeof(unsigned short);
      static const bool __b2 = sizeof(_Tp) <= sizeof(unsigned int);
      static const bool __b3 = sizeof(_Tp) <= sizeof(unsigned long);
      typedef conditional<__b3, unsigned long, unsigned long long> __cond3;
      typedef typename __cond3::type __cond3_type;
      typedef conditional<__b2, unsigned int, __cond3_type> __cond2;
      typedef typename __cond2::type __cond2_type;
      typedef conditional<__b1, unsigned short, __cond2_type> __cond1;
      typedef typename __cond1::type __cond1_type;
      typedef typename conditional<__b0, __smallest, __cond1_type>::type
 __unsigned_type;
      typedef __match_cv_qualifiers<_Tp, __unsigned_type> __cv_unsigned;
    public:
      typedef typename __cv_unsigned::__type __type;
    };
  template<typename _Tp>
    struct make_unsigned
    { typedef typename __make_unsigned_selector<_Tp>::__type type; };
  template<>
    struct make_unsigned<bool>;
  template<typename _Tp>
    struct __make_signed
    { typedef _Tp __type; };
  template<>
    struct __make_signed<char>
    { typedef signed char __type; };
  template<>
    struct __make_signed<unsigned char>
    { typedef signed char __type; };
  template<>
    struct __make_signed<unsigned short>
    { typedef signed short __type; };
  template<>
    struct __make_signed<unsigned int>
    { typedef signed int __type; };
  template<>
    struct __make_signed<unsigned long>
    { typedef signed long __type; };
  template<>
    struct __make_signed<unsigned long long>
    { typedef signed long long __type; };
  template<>
    struct __make_signed<wchar_t> : __make_signed<short unsigned int>
    { };
  template<>
    struct __make_signed<char16_t> : __make_signed<uint_least16_t>
    { };
  template<>
    struct __make_signed<char32_t> : __make_signed<uint_least32_t>
    { };
  template<>
    struct __make_signed<unsigned __int128>
    { typedef __int128 __type; };
  template<typename _Tp,
    bool _IsInt = is_integral<_Tp>::value,
    bool _IsEnum = is_enum<_Tp>::value>
    class __make_signed_selector;
  template<typename _Tp>
    class __make_signed_selector<_Tp, true, false>
    {
      typedef __make_signed<typename remove_cv<_Tp>::type> __signedt;
      typedef typename __signedt::__type __signed_type;
      typedef __match_cv_qualifiers<_Tp, __signed_type> __cv_signed;
    public:
      typedef typename __cv_signed::__type __type;
    };
  template<typename _Tp>
    class __make_signed_selector<_Tp, false, true>
    {
      typedef typename __make_unsigned_selector<_Tp>::__type __unsigned_type;
    public:
      typedef typename __make_signed_selector<__unsigned_type>::__type __type;
    };
  template<typename _Tp>
    struct make_signed
    { typedef typename __make_signed_selector<_Tp>::__type type; };
  template<>
    struct make_signed<bool>;
  template<typename _Tp>
    using make_signed_t = typename make_signed<_Tp>::type;
  template<typename _Tp>
    using make_unsigned_t = typename make_unsigned<_Tp>::type;
  template<typename _Tp>
    struct remove_extent
    { typedef _Tp type; };
  template<typename _Tp, std::size_t _Size>
    struct remove_extent<_Tp[_Size]>
    { typedef _Tp type; };
  template<typename _Tp>
    struct remove_extent<_Tp[]>
    { typedef _Tp type; };
  template<typename _Tp>
    struct remove_all_extents
    { typedef _Tp type; };
  template<typename _Tp, std::size_t _Size>
    struct remove_all_extents<_Tp[_Size]>
    { typedef typename remove_all_extents<_Tp>::type type; };
  template<typename _Tp>
    struct remove_all_extents<_Tp[]>
    { typedef typename remove_all_extents<_Tp>::type type; };
  template<typename _Tp>
    using remove_extent_t = typename remove_extent<_Tp>::type;
  template<typename _Tp>
    using remove_all_extents_t = typename remove_all_extents<_Tp>::type;
  template<typename _Tp, typename>
    struct __remove_pointer_helper
    { typedef _Tp type; };
  template<typename _Tp, typename _Up>
    struct __remove_pointer_helper<_Tp, _Up*>
    { typedef _Up type; };
  template<typename _Tp>
    struct remove_pointer
    : public __remove_pointer_helper<_Tp, typename remove_cv<_Tp>::type>
    { };
  template<typename _Tp, bool = __or_<__is_referenceable<_Tp>,
          is_void<_Tp>>::value>
    struct __add_pointer_helper
    { typedef _Tp type; };
  template<typename _Tp>
    struct __add_pointer_helper<_Tp, true>
    { typedef typename remove_reference<_Tp>::type* type; };
  template<typename _Tp>
    struct add_pointer
    : public __add_pointer_helper<_Tp>
    { };
  template<typename _Tp>
    using remove_pointer_t = typename remove_pointer<_Tp>::type;
  template<typename _Tp>
    using add_pointer_t = typename add_pointer<_Tp>::type;
  template<std::size_t _Len>
    struct __aligned_storage_msa
    {
      union __type
      {
 unsigned char __data[_Len];
 struct __attribute__((__aligned__)) { } __align;
      };
    };
  template<std::size_t _Len, std::size_t _Align =
    __alignof__(typename __aligned_storage_msa<_Len>::__type)>
    struct aligned_storage
    {
      union type
      {
 unsigned char __data[_Len];
 struct __attribute__((__aligned__((_Align)))) { } __align;
      };
    };
  template <typename... _Types>
    struct __strictest_alignment
    {
      static const size_t _S_alignment = 0;
      static const size_t _S_size = 0;
    };
  template <typename _Tp, typename... _Types>
    struct __strictest_alignment<_Tp, _Types...>
    {
      static const size_t _S_alignment =
        alignof(_Tp) > __strictest_alignment<_Types...>::_S_alignment
 ? alignof(_Tp) : __strictest_alignment<_Types...>::_S_alignment;
      static const size_t _S_size =
        sizeof(_Tp) > __strictest_alignment<_Types...>::_S_size
 ? sizeof(_Tp) : __strictest_alignment<_Types...>::_S_size;
    };
  template <size_t _Len, typename... _Types>
    struct aligned_union
    {
    private:
      static_assert(sizeof...(_Types) != 0, "At least one type is required");
      using __strictest = __strictest_alignment<_Types...>;
      static const size_t _S_len = _Len > __strictest::_S_size
 ? _Len : __strictest::_S_size;
    public:
      static const size_t alignment_value = __strictest::_S_alignment;
      typedef typename aligned_storage<_S_len, alignment_value>::type type;
    };
  template <size_t _Len, typename... _Types>
    const size_t aligned_union<_Len, _Types...>::alignment_value;
  template<typename _Up,
    bool _IsArray = is_array<_Up>::value,
    bool _IsFunction = is_function<_Up>::value>
    struct __decay_selector;
  template<typename _Up>
    struct __decay_selector<_Up, false, false>
    { typedef typename remove_cv<_Up>::type __type; };
  template<typename _Up>
    struct __decay_selector<_Up, true, false>
    { typedef typename remove_extent<_Up>::type* __type; };
  template<typename _Up>
    struct __decay_selector<_Up, false, true>
    { typedef typename add_pointer<_Up>::type __type; };
  template<typename _Tp>
    class decay
    {
      typedef typename remove_reference<_Tp>::type __remove_type;
    public:
      typedef typename __decay_selector<__remove_type>::__type type;
    };
  template<typename _Tp>
    class reference_wrapper;
  template<typename _Tp>
    struct __strip_reference_wrapper
    {
      typedef _Tp __type;
    };
  template<typename _Tp>
    struct __strip_reference_wrapper<reference_wrapper<_Tp> >
    {
      typedef _Tp& __type;
    };
  template<typename _Tp>
    struct __decay_and_strip
    {
      typedef typename __strip_reference_wrapper<
 typename decay<_Tp>::type>::__type __type;
    };
  template<bool, typename _Tp = void>
    struct enable_if
    { };
  template<typename _Tp>
    struct enable_if<true, _Tp>
    { typedef _Tp type; };
  template<typename... _Cond>
    using _Require = typename enable_if<__and_<_Cond...>::value>::type;
  template<bool _Cond, typename _Iftrue, typename _Iffalse>
    struct conditional
    { typedef _Iftrue type; };
  template<typename _Iftrue, typename _Iffalse>
    struct conditional<false, _Iftrue, _Iffalse>
    { typedef _Iffalse type; };
  template<typename... _Tp>
    struct common_type;
  struct __do_common_type_impl
  {
    template<typename _Tp, typename _Up>
      static __success_type<typename decay<decltype
       (true ? std::declval<_Tp>()
        : std::declval<_Up>())>::type> _S_test(int);
    template<typename, typename>
      static __failure_type _S_test(...);
  };
  template<typename _Tp, typename _Up>
    struct __common_type_impl
    : private __do_common_type_impl
    {
      typedef decltype(_S_test<_Tp, _Up>(0)) type;
    };
  struct __do_member_type_wrapper
  {
    template<typename _Tp>
      static __success_type<typename _Tp::type> _S_test(int);
    template<typename>
      static __failure_type _S_test(...);
  };
  template<typename _Tp>
    struct __member_type_wrapper
    : private __do_member_type_wrapper
    {
      typedef decltype(_S_test<_Tp>(0)) type;
    };
  template<typename _CTp, typename... _Args>
    struct __expanded_common_type_wrapper
    {
      typedef common_type<typename _CTp::type, _Args...> type;
    };
  template<typename... _Args>
    struct __expanded_common_type_wrapper<__failure_type, _Args...>
    { typedef __failure_type type; };
  template<typename _Tp>
    struct common_type<_Tp>
    { typedef typename decay<_Tp>::type type; };
  template<typename _Tp, typename _Up>
    struct common_type<_Tp, _Up>
    : public __common_type_impl<_Tp, _Up>::type
    { };
  template<typename _Tp, typename _Up, typename... _Vp>
    struct common_type<_Tp, _Up, _Vp...>
    : public __expanded_common_type_wrapper<typename __member_type_wrapper<
               common_type<_Tp, _Up>>::type, _Vp...>::type
    { };
  template<typename _Tp>
    struct underlying_type
    {
      typedef __underlying_type(_Tp) type;
    };
  template<typename _Tp>
    struct __declval_protector
    {
      static const bool __stop = false;
    };
  template<typename _Tp>
    auto declval() noexcept -> decltype(__declval<_Tp>(0))
    {
      static_assert(__declval_protector<_Tp>::__stop,
      "declval() must not be used!");
      return __declval<_Tp>(0);
    }
  template<typename _Signature>
    class result_of;
  struct __invoke_memfun_ref { };
  struct __invoke_memfun_deref { };
  struct __invoke_memobj_ref { };
  struct __invoke_memobj_deref { };
  struct __invoke_other { };
  template<typename _Tp, typename _Tag>
    struct __result_of_success : __success_type<_Tp>
    { using __invoke_type = _Tag; };
  struct __result_of_memfun_ref_impl
  {
    template<typename _Fp, typename _Tp1, typename... _Args>
      static __result_of_success<decltype(
      (std::declval<_Tp1>().*std::declval<_Fp>())(std::declval<_Args>()...)
      ), __invoke_memfun_ref> _S_test(int);
    template<typename...>
      static __failure_type _S_test(...);
  };
  template<typename _MemPtr, typename _Arg, typename... _Args>
    struct __result_of_memfun_ref
    : private __result_of_memfun_ref_impl
    {
      typedef decltype(_S_test<_MemPtr, _Arg, _Args...>(0)) type;
    };
  struct __result_of_memfun_deref_impl
  {
    template<typename _Fp, typename _Tp1, typename... _Args>
      static __result_of_success<decltype(
      ((*std::declval<_Tp1>()).*std::declval<_Fp>())(std::declval<_Args>()...)
      ), __invoke_memfun_deref> _S_test(int);
    template<typename...>
      static __failure_type _S_test(...);
  };
  template<typename _MemPtr, typename _Arg, typename... _Args>
    struct __result_of_memfun_deref
    : private __result_of_memfun_deref_impl
    {
      typedef decltype(_S_test<_MemPtr, _Arg, _Args...>(0)) type;
    };
  struct __result_of_memobj_ref_impl
  {
    template<typename _Fp, typename _Tp1>
      static __result_of_success<decltype(
      std::declval<_Tp1>().*std::declval<_Fp>()
      ), __invoke_memobj_ref> _S_test(int);
    template<typename, typename>
      static __failure_type _S_test(...);
  };
  template<typename _MemPtr, typename _Arg>
    struct __result_of_memobj_ref
    : private __result_of_memobj_ref_impl
    {
      typedef decltype(_S_test<_MemPtr, _Arg>(0)) type;
    };
  struct __result_of_memobj_deref_impl
  {
    template<typename _Fp, typename _Tp1>
      static __result_of_success<decltype(
      (*std::declval<_Tp1>()).*std::declval<_Fp>()
      ), __invoke_memobj_deref> _S_test(int);
    template<typename, typename>
      static __failure_type _S_test(...);
  };
  template<typename _MemPtr, typename _Arg>
    struct __result_of_memobj_deref
    : private __result_of_memobj_deref_impl
    {
      typedef decltype(_S_test<_MemPtr, _Arg>(0)) type;
    };
  template<typename _MemPtr, typename _Arg>
    struct __result_of_memobj;
  template<typename _Res, typename _Class, typename _Arg>
    struct __result_of_memobj<_Res _Class::*, _Arg>
    {
      typedef typename remove_cv<typename remove_reference<
        _Arg>::type>::type _Argval;
      typedef _Res _Class::* _MemPtr;
      typedef typename conditional<__or_<is_same<_Argval, _Class>,
        is_base_of<_Class, _Argval>>::value,
        __result_of_memobj_ref<_MemPtr, _Arg>,
        __result_of_memobj_deref<_MemPtr, _Arg>
      >::type::type type;
    };
  template<typename _MemPtr, typename _Arg, typename... _Args>
    struct __result_of_memfun;
  template<typename _Res, typename _Class, typename _Arg, typename... _Args>
    struct __result_of_memfun<_Res _Class::*, _Arg, _Args...>
    {
      typedef typename remove_cv<typename remove_reference<
        _Arg>::type>::type _Argval;
      typedef _Res _Class::* _MemPtr;
      typedef typename conditional<__or_<is_same<_Argval, _Class>,
        is_base_of<_Class, _Argval>>::value,
        __result_of_memfun_ref<_MemPtr, _Arg, _Args...>,
        __result_of_memfun_deref<_MemPtr, _Arg, _Args...>
      >::type::type type;
    };
  template<typename _Tp, typename _Up = typename decay<_Tp>::type>
    struct __inv_unwrap
    {
      using type = _Tp;
    };
  template<typename _Tp, typename _Up>
    struct __inv_unwrap<_Tp, reference_wrapper<_Up>>
    {
      using type = _Up&;
    };
  template<bool, bool, typename _Functor, typename... _ArgTypes>
    struct __result_of_impl
    {
      typedef __failure_type type;
    };
  template<typename _MemPtr, typename _Arg>
    struct __result_of_impl<true, false, _MemPtr, _Arg>
    : public __result_of_memobj<typename decay<_MemPtr>::type,
    typename __inv_unwrap<_Arg>::type>
    { };
  template<typename _MemPtr, typename _Arg, typename... _Args>
    struct __result_of_impl<false, true, _MemPtr, _Arg, _Args...>
    : public __result_of_memfun<typename decay<_MemPtr>::type,
    typename __inv_unwrap<_Arg>::type, _Args...>
    { };
  struct __result_of_other_impl
  {
    template<typename _Fn, typename... _Args>
      static __result_of_success<decltype(
      std::declval<_Fn>()(std::declval<_Args>()...)
      ), __invoke_other> _S_test(int);
    template<typename...>
      static __failure_type _S_test(...);
  };
  template<typename _Functor, typename... _ArgTypes>
    struct __result_of_impl<false, false, _Functor, _ArgTypes...>
    : private __result_of_other_impl
    {
      typedef decltype(_S_test<_Functor, _ArgTypes...>(0)) type;
    };
  template<typename _Functor, typename... _ArgTypes>
    struct __invoke_result
    : public __result_of_impl<
        is_member_object_pointer<
          typename remove_reference<_Functor>::type
        >::value,
        is_member_function_pointer<
          typename remove_reference<_Functor>::type
        >::value,
 _Functor, _ArgTypes...
      >::type
    { };
  template<typename _Functor, typename... _ArgTypes>
    struct result_of<_Functor(_ArgTypes...)>
    : public __invoke_result<_Functor, _ArgTypes...>
    { };
  template<size_t _Len, size_t _Align =
     __alignof__(typename __aligned_storage_msa<_Len>::__type)>
    using aligned_storage_t = typename aligned_storage<_Len, _Align>::type;
  template <size_t _Len, typename... _Types>
    using aligned_union_t = typename aligned_union<_Len, _Types...>::type;
  template<typename _Tp>
    using decay_t = typename decay<_Tp>::type;
  template<bool _Cond, typename _Tp = void>
    using enable_if_t = typename enable_if<_Cond, _Tp>::type;
  template<bool _Cond, typename _Iftrue, typename _Iffalse>
    using conditional_t = typename conditional<_Cond, _Iftrue, _Iffalse>::type;
  template<typename... _Tp>
    using common_type_t = typename common_type<_Tp...>::type;
  template<typename _Tp>
    using underlying_type_t = typename underlying_type<_Tp>::type;
  template<typename _Tp>
    using result_of_t = typename result_of<_Tp>::type;
  template<typename...> using __void_t = void;
  template<typename...> using void_t = void;
  template<typename _Default, typename _AlwaysVoid,
    template<typename...> class _Op, typename... _Args>
    struct __detector
    {
      using value_t = false_type;
      using type = _Default;
    };
  template<typename _Default, template<typename...> class _Op,
     typename... _Args>
    struct __detector<_Default, __void_t<_Op<_Args...>>, _Op, _Args...>
    {
      using value_t = true_type;
      using type = _Op<_Args...>;
    };
  template<typename _Default, template<typename...> class _Op,
    typename... _Args>
    using __detected_or = __detector<_Default, void, _Op, _Args...>;
  template<typename _Default, template<typename...> class _Op,
    typename... _Args>
    using __detected_or_t
      = typename __detected_or<_Default, _Op, _Args...>::type;
  template <typename _Tp>
    struct __is_swappable;
  template <typename _Tp>
    struct __is_nothrow_swappable;
  template<typename... _Elements>
    class tuple;
  template<typename>
    struct __is_tuple_like_impl : false_type
    { };
  template<typename... _Tps>
    struct __is_tuple_like_impl<tuple<_Tps...>> : true_type
    { };
  template<typename _Tp>
    struct __is_tuple_like
    : public __is_tuple_like_impl<typename remove_cv<
      typename remove_reference<_Tp>::type>::type>::type
    { };
  template<typename _Tp>
    inline
    typename enable_if<__and_<__not_<__is_tuple_like<_Tp>>,
         is_move_constructible<_Tp>,
         is_move_assignable<_Tp>>::value>::type
    swap(_Tp&, _Tp&)
    noexcept(__and_<is_nothrow_move_constructible<_Tp>,
             is_nothrow_move_assignable<_Tp>>::value);
  template<typename _Tp, size_t _Nm>
    inline
    typename enable_if<__is_swappable<_Tp>::value>::type
    swap(_Tp (&__a)[_Nm], _Tp (&__b)[_Nm])
    noexcept(__is_nothrow_swappable<_Tp>::value);
  namespace __swappable_details {
    using std::swap;
    struct __do_is_swappable_impl
    {
      template<typename _Tp, typename
               = decltype(swap(std::declval<_Tp&>(), std::declval<_Tp&>()))>
        static true_type __test(int);
      template<typename>
        static false_type __test(...);
    };
    struct __do_is_nothrow_swappable_impl
    {
      template<typename _Tp>
        static __bool_constant<
          noexcept(swap(std::declval<_Tp&>(), std::declval<_Tp&>()))
        > __test(int);
      template<typename>
        static false_type __test(...);
    };
  }
  template<typename _Tp>
    struct __is_swappable_impl
    : public __swappable_details::__do_is_swappable_impl
    {
      typedef decltype(__test<_Tp>(0)) type;
    };
  template<typename _Tp>
    struct __is_nothrow_swappable_impl
    : public __swappable_details::__do_is_nothrow_swappable_impl
    {
      typedef decltype(__test<_Tp>(0)) type;
    };
  template<typename _Tp>
    struct __is_swappable
    : public __is_swappable_impl<_Tp>::type
    { };
  template<typename _Tp>
    struct __is_nothrow_swappable
    : public __is_nothrow_swappable_impl<_Tp>::type
    { };
  template<typename _Tp>
    struct is_swappable
    : public __is_swappable_impl<_Tp>::type
    { };
  template<typename _Tp>
    struct is_nothrow_swappable
    : public __is_nothrow_swappable_impl<_Tp>::type
    { };
  template<typename _Tp>
    constexpr bool is_swappable_v =
      is_swappable<_Tp>::value;
  template<typename _Tp>
    constexpr bool is_nothrow_swappable_v =
      is_nothrow_swappable<_Tp>::value;
  namespace __swappable_with_details {
    using std::swap;
    struct __do_is_swappable_with_impl
    {
      template<typename _Tp, typename _Up, typename
               = decltype(swap(std::declval<_Tp>(), std::declval<_Up>())),
               typename
               = decltype(swap(std::declval<_Up>(), std::declval<_Tp>()))>
        static true_type __test(int);
      template<typename, typename>
        static false_type __test(...);
    };
    struct __do_is_nothrow_swappable_with_impl
    {
      template<typename _Tp, typename _Up>
        static __bool_constant<
          noexcept(swap(std::declval<_Tp>(), std::declval<_Up>()))
          &&
          noexcept(swap(std::declval<_Up>(), std::declval<_Tp>()))
        > __test(int);
      template<typename, typename>
        static false_type __test(...);
    };
  }
  template<typename _Tp, typename _Up>
    struct __is_swappable_with_impl
    : public __swappable_with_details::__do_is_swappable_with_impl
    {
      typedef decltype(__test<_Tp, _Up>(0)) type;
    };
  template<typename _Tp>
    struct __is_swappable_with_impl<_Tp&, _Tp&>
    : public __swappable_details::__do_is_swappable_impl
    {
      typedef decltype(__test<_Tp&>(0)) type;
    };
  template<typename _Tp, typename _Up>
    struct __is_nothrow_swappable_with_impl
    : public __swappable_with_details::__do_is_nothrow_swappable_with_impl
    {
      typedef decltype(__test<_Tp, _Up>(0)) type;
    };
  template<typename _Tp>
    struct __is_nothrow_swappable_with_impl<_Tp&, _Tp&>
    : public __swappable_details::__do_is_nothrow_swappable_impl
    {
      typedef decltype(__test<_Tp&>(0)) type;
    };
  template<typename _Tp, typename _Up>
    struct is_swappable_with
    : public __is_swappable_with_impl<_Tp, _Up>::type
    { };
  template<typename _Tp, typename _Up>
    struct is_nothrow_swappable_with
    : public __is_nothrow_swappable_with_impl<_Tp, _Up>::type
    { };
  template<typename _Tp, typename _Up>
    constexpr bool is_swappable_with_v =
      is_swappable_with<_Tp, _Up>::value;
  template<typename _Tp, typename _Up>
    constexpr bool is_nothrow_swappable_with_v =
      is_nothrow_swappable_with<_Tp, _Up>::value;
  template<typename _Result, typename _Ret, typename = void>
    struct __is_invocable_impl : false_type { };
  template<typename _Result, typename _Ret>
    struct __is_invocable_impl<_Result, _Ret, __void_t<typename _Result::type>>
    : __or_<is_void<_Ret>, is_convertible<typename _Result::type, _Ret>>::type
    { };
  template<typename _Fn, typename... _ArgTypes>
    struct __is_invocable
    : __is_invocable_impl<__invoke_result<_Fn, _ArgTypes...>, void>::type
    { };
  template<typename _Fn, typename _Tp, typename... _Args>
    constexpr bool __call_is_nt(__invoke_memfun_ref)
    {
      using _Up = typename __inv_unwrap<_Tp>::type;
      return noexcept((std::declval<_Up>().*std::declval<_Fn>())(
     std::declval<_Args>()...));
    }
  template<typename _Fn, typename _Tp, typename... _Args>
    constexpr bool __call_is_nt(__invoke_memfun_deref)
    {
      return noexcept(((*std::declval<_Tp>()).*std::declval<_Fn>())(
     std::declval<_Args>()...));
    }
  template<typename _Fn, typename _Tp>
    constexpr bool __call_is_nt(__invoke_memobj_ref)
    {
      using _Up = typename __inv_unwrap<_Tp>::type;
      return noexcept(std::declval<_Up>().*std::declval<_Fn>());
    }
  template<typename _Fn, typename _Tp>
    constexpr bool __call_is_nt(__invoke_memobj_deref)
    {
      return noexcept((*std::declval<_Tp>()).*std::declval<_Fn>());
    }
  template<typename _Fn, typename... _Args>
    constexpr bool __call_is_nt(__invoke_other)
    {
      return noexcept(std::declval<_Fn>()(std::declval<_Args>()...));
    }
  template<typename _Result, typename _Fn, typename... _Args>
    struct __call_is_nothrow
    : __bool_constant<
 std::__call_is_nt<_Fn, _Args...>(typename _Result::__invoke_type{})
      >
    { };
  template<typename _Fn, typename... _Args>
    using __call_is_nothrow_
      = __call_is_nothrow<__invoke_result<_Fn, _Args...>, _Fn, _Args...>;
  template<typename _Fn, typename... _Args>
    struct __is_nothrow_invocable
    : __and_<__is_invocable<_Fn, _Args...>,
             __call_is_nothrow_<_Fn, _Args...>>::type
    { };
  struct __nonesuch {
    __nonesuch() = delete;
    ~__nonesuch() = delete;
    __nonesuch(__nonesuch const&) = delete;
    void operator=(__nonesuch const&) = delete;
  };

}
namespace std
{

  template<typename _Tp>
    constexpr _Tp&&
    forward(typename std::remove_reference<_Tp>::type& __t) noexcept
    { return static_cast<_Tp&&>(__t); }
  template<typename _Tp>
    constexpr _Tp&&
    forward(typename std::remove_reference<_Tp>::type&& __t) noexcept
    {
      static_assert(!std::is_lvalue_reference<_Tp>::value, "template argument"
      " substituting _Tp is an lvalue reference type");
      return static_cast<_Tp&&>(__t);
    }
  template<typename _Tp>
    constexpr typename std::remove_reference<_Tp>::type&&
    move(_Tp&& __t) noexcept
    { return static_cast<typename std::remove_reference<_Tp>::type&&>(__t); }
  template<typename _Tp>
    struct __move_if_noexcept_cond
    : public __and_<__not_<is_nothrow_move_constructible<_Tp>>,
                    is_copy_constructible<_Tp>>::type { };
  template<typename _Tp>
    constexpr typename
    conditional<__move_if_noexcept_cond<_Tp>::value, const _Tp&, _Tp&&>::type
    move_if_noexcept(_Tp& __x) noexcept
    { return std::move(__x); }
  template<typename _Tp>
    inline _Tp*
    addressof(_Tp& __r) noexcept
    { return std::__addressof(__r); }
  template<typename _Tp>
    const _Tp* addressof(const _Tp&&) = delete;
  template <typename _Tp, typename _Up = _Tp>
    inline _Tp
    __exchange(_Tp& __obj, _Up&& __new_val)
    {
      _Tp __old_val = std::move(__obj);
      __obj = std::forward<_Up>(__new_val);
      return __old_val;
    }
  template<typename _Tp>
    inline
    typename enable_if<__and_<__not_<__is_tuple_like<_Tp>>,
         is_move_constructible<_Tp>,
         is_move_assignable<_Tp>>::value>::type
    swap(_Tp& __a, _Tp& __b)
    noexcept(__and_<is_nothrow_move_constructible<_Tp>,
             is_nothrow_move_assignable<_Tp>>::value)
    {
     
      _Tp __tmp = std::move(__a);
      __a = std::move(__b);
      __b = std::move(__tmp);
    }
  template<typename _Tp, size_t _Nm>
    inline
    typename enable_if<__is_swappable<_Tp>::value>::type
    swap(_Tp (&__a)[_Nm], _Tp (&__b)[_Nm])
    noexcept(__is_nothrow_swappable<_Tp>::value)
    {
      for (size_t __n = 0; __n < _Nm; ++__n)
 swap(__a[__n], __b[__n]);
    }

}
namespace std
{

  struct piecewise_construct_t { explicit piecewise_construct_t() = default; };
  constexpr piecewise_construct_t piecewise_construct =
    piecewise_construct_t();
  template<typename...>
    class tuple;
  template<std::size_t...>
    struct _Index_tuple;
  template <bool, typename _T1, typename _T2>
    struct _PCC
    {
      template <typename _U1, typename _U2>
      static constexpr bool _ConstructiblePair()
      {
 return __and_<is_constructible<_T1, const _U1&>,
        is_constructible<_T2, const _U2&>>::value;
      }
      template <typename _U1, typename _U2>
      static constexpr bool _ImplicitlyConvertiblePair()
      {
 return __and_<is_convertible<const _U1&, _T1>,
        is_convertible<const _U2&, _T2>>::value;
      }
      template <typename _U1, typename _U2>
      static constexpr bool _MoveConstructiblePair()
      {
 return __and_<is_constructible<_T1, _U1&&>,
        is_constructible<_T2, _U2&&>>::value;
      }
      template <typename _U1, typename _U2>
      static constexpr bool _ImplicitlyMoveConvertiblePair()
      {
 return __and_<is_convertible<_U1&&, _T1>,
        is_convertible<_U2&&, _T2>>::value;
      }
      template <bool __implicit, typename _U1, typename _U2>
      static constexpr bool _CopyMovePair()
      {
 using __do_converts = __and_<is_convertible<const _U1&, _T1>,
      is_convertible<_U2&&, _T2>>;
 using __converts = typename conditional<__implicit,
           __do_converts,
           __not_<__do_converts>>::type;
 return __and_<is_constructible<_T1, const _U1&>,
        is_constructible<_T2, _U2&&>,
        __converts
        >::value;
      }
      template <bool __implicit, typename _U1, typename _U2>
      static constexpr bool _MoveCopyPair()
      {
 using __do_converts = __and_<is_convertible<_U1&&, _T1>,
      is_convertible<const _U2&, _T2>>;
 using __converts = typename conditional<__implicit,
           __do_converts,
           __not_<__do_converts>>::type;
 return __and_<is_constructible<_T1, _U1&&>,
        is_constructible<_T2, const _U2&&>,
        __converts
        >::value;
      }
  };
  template <typename _T1, typename _T2>
    struct _PCC<false, _T1, _T2>
    {
      template <typename _U1, typename _U2>
      static constexpr bool _ConstructiblePair()
      {
 return false;
      }
      template <typename _U1, typename _U2>
      static constexpr bool _ImplicitlyConvertiblePair()
      {
 return false;
      }
      template <typename _U1, typename _U2>
      static constexpr bool _MoveConstructiblePair()
      {
 return false;
      }
      template <typename _U1, typename _U2>
      static constexpr bool _ImplicitlyMoveConvertiblePair()
      {
 return false;
      }
  };
  struct __nonesuch_no_braces : std::__nonesuch {
    explicit __nonesuch_no_braces(const __nonesuch&) = delete;
  };
  template<typename _T1, typename _T2>
    struct pair
    {
      typedef _T1 first_type;
      typedef _T2 second_type;
      _T1 first;
      _T2 second;
      template <typename _U1 = _T1,
                typename _U2 = _T2,
                typename enable_if<__and_<
                                     __is_implicitly_default_constructible<_U1>,
                                     __is_implicitly_default_constructible<_U2>>
                                   ::value, bool>::type = true>
      constexpr pair()
      : first(), second() { }
      template <typename _U1 = _T1,
                typename _U2 = _T2,
                typename enable_if<__and_<
                       is_default_constructible<_U1>,
                       is_default_constructible<_U2>,
                       __not_<
                         __and_<__is_implicitly_default_constructible<_U1>,
                                __is_implicitly_default_constructible<_U2>>>>
                                   ::value, bool>::type = false>
      explicit constexpr pair()
      : first(), second() { }
      using _PCCP = _PCC<true, _T1, _T2>;
      template<typename _U1 = _T1, typename _U2=_T2, typename
        enable_if<_PCCP::template
      _ConstructiblePair<_U1, _U2>()
                  && _PCCP::template
      _ImplicitlyConvertiblePair<_U1, _U2>(),
                         bool>::type=true>
      constexpr pair(const _T1& __a, const _T2& __b)
      : first(__a), second(__b) { }
       template<typename _U1 = _T1, typename _U2=_T2, typename
  enable_if<_PCCP::template
       _ConstructiblePair<_U1, _U2>()
                   && !_PCCP::template
       _ImplicitlyConvertiblePair<_U1, _U2>(),
                         bool>::type=false>
      explicit constexpr pair(const _T1& __a, const _T2& __b)
      : first(__a), second(__b) { }
      template <typename _U1, typename _U2>
        using _PCCFP = _PCC<!is_same<_T1, _U1>::value
       || !is_same<_T2, _U2>::value,
       _T1, _T2>;
      template<typename _U1, typename _U2, typename
        enable_if<_PCCFP<_U1, _U2>::template
      _ConstructiblePair<_U1, _U2>()
                  && _PCCFP<_U1, _U2>::template
      _ImplicitlyConvertiblePair<_U1, _U2>(),
     bool>::type=true>
        constexpr pair(const pair<_U1, _U2>& __p)
        : first(__p.first), second(__p.second) { }
      template<typename _U1, typename _U2, typename
        enable_if<_PCCFP<_U1, _U2>::template
      _ConstructiblePair<_U1, _U2>()
    && !_PCCFP<_U1, _U2>::template
      _ImplicitlyConvertiblePair<_U1, _U2>(),
                         bool>::type=false>
 explicit constexpr pair(const pair<_U1, _U2>& __p)
 : first(__p.first), second(__p.second) { }
      constexpr pair(const pair&) = default;
      constexpr pair(pair&&) = default;
      template<typename _U1, typename
        enable_if<_PCCP::template
      _MoveCopyPair<true, _U1, _T2>(),
                         bool>::type=true>
       constexpr pair(_U1&& __x, const _T2& __y)
       : first(std::forward<_U1>(__x)), second(__y) { }
      template<typename _U1, typename
        enable_if<_PCCP::template
      _MoveCopyPair<false, _U1, _T2>(),
                         bool>::type=false>
       explicit constexpr pair(_U1&& __x, const _T2& __y)
       : first(std::forward<_U1>(__x)), second(__y) { }
      template<typename _U2, typename
        enable_if<_PCCP::template
      _CopyMovePair<true, _T1, _U2>(),
                         bool>::type=true>
       constexpr pair(const _T1& __x, _U2&& __y)
       : first(__x), second(std::forward<_U2>(__y)) { }
      template<typename _U2, typename
        enable_if<_PCCP::template
      _CopyMovePair<false, _T1, _U2>(),
                         bool>::type=false>
       explicit pair(const _T1& __x, _U2&& __y)
       : first(__x), second(std::forward<_U2>(__y)) { }
      template<typename _U1, typename _U2, typename
        enable_if<_PCCP::template
      _MoveConstructiblePair<_U1, _U2>()
     && _PCCP::template
      _ImplicitlyMoveConvertiblePair<_U1, _U2>(),
                         bool>::type=true>
 constexpr pair(_U1&& __x, _U2&& __y)
 : first(std::forward<_U1>(__x)), second(std::forward<_U2>(__y)) { }
      template<typename _U1, typename _U2, typename
        enable_if<_PCCP::template
      _MoveConstructiblePair<_U1, _U2>()
     && !_PCCP::template
      _ImplicitlyMoveConvertiblePair<_U1, _U2>(),
                         bool>::type=false>
 explicit constexpr pair(_U1&& __x, _U2&& __y)
 : first(std::forward<_U1>(__x)), second(std::forward<_U2>(__y)) { }
      template<typename _U1, typename _U2, typename
        enable_if<_PCCFP<_U1, _U2>::template
      _MoveConstructiblePair<_U1, _U2>()
     && _PCCFP<_U1, _U2>::template
      _ImplicitlyMoveConvertiblePair<_U1, _U2>(),
                         bool>::type=true>
 constexpr pair(pair<_U1, _U2>&& __p)
 : first(std::forward<_U1>(__p.first)),
   second(std::forward<_U2>(__p.second)) { }
      template<typename _U1, typename _U2, typename
        enable_if<_PCCFP<_U1, _U2>::template
      _MoveConstructiblePair<_U1, _U2>()
     && !_PCCFP<_U1, _U2>::template
      _ImplicitlyMoveConvertiblePair<_U1, _U2>(),
                         bool>::type=false>
 explicit constexpr pair(pair<_U1, _U2>&& __p)
 : first(std::forward<_U1>(__p.first)),
   second(std::forward<_U2>(__p.second)) { }
      template<typename... _Args1, typename... _Args2>
        pair(piecewise_construct_t, tuple<_Args1...>, tuple<_Args2...>);
      pair&
      operator=(typename conditional<
  __and_<is_copy_assignable<_T1>,
         is_copy_assignable<_T2>>::value,
  const pair&, const __nonesuch_no_braces&>::type __p)
      {
 first = __p.first;
 second = __p.second;
 return *this;
      }
      pair&
      operator=(typename conditional<
  __not_<__and_<is_copy_assignable<_T1>,
                is_copy_assignable<_T2>>>::value,
  const pair&, const __nonesuch_no_braces&>::type __p) = delete;
      pair&
      operator=(typename conditional<
  __and_<is_move_assignable<_T1>,
         is_move_assignable<_T2>>::value,
  pair&&, __nonesuch_no_braces&&>::type __p)
      noexcept(__and_<is_nothrow_move_assignable<_T1>,
               is_nothrow_move_assignable<_T2>>::value)
      {
 first = std::forward<first_type>(__p.first);
 second = std::forward<second_type>(__p.second);
 return *this;
      }
      template<typename _U1, typename _U2>
      typename enable_if<__and_<is_assignable<_T1&, const _U1&>,
    is_assignable<_T2&, const _U2&>>::value,
    pair&>::type
 operator=(const pair<_U1, _U2>& __p)
 {
   first = __p.first;
   second = __p.second;
   return *this;
 }
      template<typename _U1, typename _U2>
      typename enable_if<__and_<is_assignable<_T1&, _U1&&>,
    is_assignable<_T2&, _U2&&>>::value,
    pair&>::type
 operator=(pair<_U1, _U2>&& __p)
 {
   first = std::forward<_U1>(__p.first);
   second = std::forward<_U2>(__p.second);
   return *this;
 }
      void
      swap(pair& __p)
      noexcept(__and_<__is_nothrow_swappable<_T1>,
                      __is_nothrow_swappable<_T2>>::value)
      {
 using std::swap;
 swap(first, __p.first);
 swap(second, __p.second);
      }
    private:
      template<typename... _Args1, std::size_t... _Indexes1,
               typename... _Args2, std::size_t... _Indexes2>
        pair(tuple<_Args1...>&, tuple<_Args2...>&,
             _Index_tuple<_Indexes1...>, _Index_tuple<_Indexes2...>);
    };
  template<typename _T1, typename _T2>
    inline constexpr bool
    operator==(const pair<_T1, _T2>& __x, const pair<_T1, _T2>& __y)
    { return __x.first == __y.first && __x.second == __y.second; }
  template<typename _T1, typename _T2>
    inline constexpr bool
    operator<(const pair<_T1, _T2>& __x, const pair<_T1, _T2>& __y)
    { return __x.first < __y.first
      || (!(__y.first < __x.first) && __x.second < __y.second); }
  template<typename _T1, typename _T2>
    inline constexpr bool
    operator!=(const pair<_T1, _T2>& __x, const pair<_T1, _T2>& __y)
    { return !(__x == __y); }
  template<typename _T1, typename _T2>
    inline constexpr bool
    operator>(const pair<_T1, _T2>& __x, const pair<_T1, _T2>& __y)
    { return __y < __x; }
  template<typename _T1, typename _T2>
    inline constexpr bool
    operator<=(const pair<_T1, _T2>& __x, const pair<_T1, _T2>& __y)
    { return !(__y < __x); }
  template<typename _T1, typename _T2>
    inline constexpr bool
    operator>=(const pair<_T1, _T2>& __x, const pair<_T1, _T2>& __y)
    { return !(__x < __y); }
  template<typename _T1, typename _T2>
    inline
    typename enable_if<__and_<__is_swappable<_T1>,
                              __is_swappable<_T2>>::value>::type
    swap(pair<_T1, _T2>& __x, pair<_T1, _T2>& __y)
    noexcept(noexcept(__x.swap(__y)))
    { __x.swap(__y); }
  template<typename _T1, typename _T2>
    typename enable_if<!__and_<__is_swappable<_T1>,
          __is_swappable<_T2>>::value>::type
    swap(pair<_T1, _T2>&, pair<_T1, _T2>&) = delete;
  template<typename _T1, typename _T2>
    constexpr pair<typename __decay_and_strip<_T1>::__type,
                   typename __decay_and_strip<_T2>::__type>
    make_pair(_T1&& __x, _T2&& __y)
    {
      typedef typename __decay_and_strip<_T1>::__type __ds_type1;
      typedef typename __decay_and_strip<_T2>::__type __ds_type2;
      typedef pair<__ds_type1, __ds_type2> __pair_type;
      return __pair_type(std::forward<_T1>(__x), std::forward<_T2>(__y));
    }

}
       
namespace std
{

  struct input_iterator_tag { };
  struct output_iterator_tag { };
  struct forward_iterator_tag : public input_iterator_tag { };
  struct bidirectional_iterator_tag : public forward_iterator_tag { };
  struct random_access_iterator_tag : public bidirectional_iterator_tag { };
  template<typename _Category, typename _Tp, typename _Distance = ptrdiff_t,
           typename _Pointer = _Tp*, typename _Reference = _Tp&>
    struct iterator
    {
      typedef _Category iterator_category;
      typedef _Tp value_type;
      typedef _Distance difference_type;
      typedef _Pointer pointer;
      typedef _Reference reference;
    };
  template<typename _Iterator, typename = __void_t<>>
    struct __iterator_traits { };
  template<typename _Iterator>
    struct __iterator_traits<_Iterator,
        __void_t<typename _Iterator::iterator_category,
          typename _Iterator::value_type,
          typename _Iterator::difference_type,
          typename _Iterator::pointer,
          typename _Iterator::reference>>
    {
      typedef typename _Iterator::iterator_category iterator_category;
      typedef typename _Iterator::value_type value_type;
      typedef typename _Iterator::difference_type difference_type;
      typedef typename _Iterator::pointer pointer;
      typedef typename _Iterator::reference reference;
    };
  template<typename _Iterator>
    struct iterator_traits
    : public __iterator_traits<_Iterator> { };
  template<typename _Tp>
    struct iterator_traits<_Tp*>
    {
      typedef random_access_iterator_tag iterator_category;
      typedef _Tp value_type;
      typedef ptrdiff_t difference_type;
      typedef _Tp* pointer;
      typedef _Tp& reference;
    };
  template<typename _Tp>
    struct iterator_traits<const _Tp*>
    {
      typedef random_access_iterator_tag iterator_category;
      typedef _Tp value_type;
      typedef ptrdiff_t difference_type;
      typedef const _Tp* pointer;
      typedef const _Tp& reference;
    };
  template<typename _Iter>
    inline constexpr
    typename iterator_traits<_Iter>::iterator_category
    __iterator_category(const _Iter&)
    { return typename iterator_traits<_Iter>::iterator_category(); }
  template<typename _InIter>
    using _RequireInputIter = typename
      enable_if<is_convertible<typename
  iterator_traits<_InIter>::iterator_category,
          input_iterator_tag>::value>::type;

}
       
namespace std
{


  template <typename> struct _List_iterator;
  template <typename> struct _List_const_iterator;

  template<typename _InputIterator>
    inline constexpr
    typename iterator_traits<_InputIterator>::difference_type
    __distance(_InputIterator __first, _InputIterator __last,
               input_iterator_tag)
    {
     
      typename iterator_traits<_InputIterator>::difference_type __n = 0;
      while (__first != __last)
 {
   ++__first;
   ++__n;
 }
      return __n;
    }
  template<typename _RandomAccessIterator>
    inline constexpr
    typename iterator_traits<_RandomAccessIterator>::difference_type
    __distance(_RandomAccessIterator __first, _RandomAccessIterator __last,
               random_access_iterator_tag)
    {
     
      return __last - __first;
    }
  template<typename _Tp>
    ptrdiff_t
    __distance(std::_List_iterator<_Tp>,
        std::_List_iterator<_Tp>,
        input_iterator_tag);
  template<typename _Tp>
    ptrdiff_t
    __distance(std::_List_const_iterator<_Tp>,
        std::_List_const_iterator<_Tp>,
        input_iterator_tag);
  template<typename _InputIterator>
    inline
    typename iterator_traits<_InputIterator>::difference_type
    distance(_InputIterator __first, _InputIterator __last)
    {
      return std::__distance(__first, __last,
        std::__iterator_category(__first));
    }
  template<typename _InputIterator, typename _Distance>
    inline constexpr void
    __advance(_InputIterator& __i, _Distance __n, input_iterator_tag)
    {
     
      ;
      while (__n--)
 ++__i;
    }
  template<typename _BidirectionalIterator, typename _Distance>
    inline constexpr void
    __advance(_BidirectionalIterator& __i, _Distance __n,
       bidirectional_iterator_tag)
    {
     
      if (__n > 0)
        while (__n--)
   ++__i;
      else
        while (__n++)
   --__i;
    }
  template<typename _RandomAccessIterator, typename _Distance>
    inline constexpr void
    __advance(_RandomAccessIterator& __i, _Distance __n,
              random_access_iterator_tag)
    {
     
      if (__builtin_constant_p(__n) && __n == 1)
 ++__i;
      else if (__builtin_constant_p(__n) && __n == -1)
 --__i;
      else
 __i += __n;
    }
  template<typename _InputIterator, typename _Distance>
    inline void
    advance(_InputIterator& __i, _Distance __n)
    {
      typename iterator_traits<_InputIterator>::difference_type __d = __n;
      std::__advance(__i, __d, std::__iterator_category(__i));
    }
  template<typename _InputIterator>
    inline _InputIterator
    next(_InputIterator __x, typename
  iterator_traits<_InputIterator>::difference_type __n = 1)
    {
     
      std::advance(__x, __n);
      return __x;
    }
  template<typename _BidirectionalIterator>
    inline _BidirectionalIterator
    prev(_BidirectionalIterator __x, typename
  iterator_traits<_BidirectionalIterator>::difference_type __n = 1)
    {
     
      std::advance(__x, -__n);
      return __x;
    }

}
namespace std
{

  class __undefined;
  template<typename _Tp>
    struct __get_first_arg
    { using type = __undefined; };
  template<template<typename, typename...> class _Template, typename _Tp,
           typename... _Types>
    struct __get_first_arg<_Template<_Tp, _Types...>>
    { using type = _Tp; };
  template<typename _Tp>
    using __get_first_arg_t = typename __get_first_arg<_Tp>::type;
  template<typename _Tp, typename _Up>
    struct __replace_first_arg
    { };
  template<template<typename, typename...> class _Template, typename _Up,
           typename _Tp, typename... _Types>
    struct __replace_first_arg<_Template<_Tp, _Types...>, _Up>
    { using type = _Template<_Up, _Types...>; };
  template<typename _Tp, typename _Up>
    using __replace_first_arg_t = typename __replace_first_arg<_Tp, _Up>::type;
  template<typename _Tp>
    using __make_not_void
      = typename conditional<is_void<_Tp>::value, __undefined, _Tp>::type;
  template<typename _Ptr>
    struct pointer_traits
    {
    private:
      template<typename _Tp>
 using __element_type = typename _Tp::element_type;
      template<typename _Tp>
 using __difference_type = typename _Tp::difference_type;
      template<typename _Tp, typename _Up, typename = void>
 struct __rebind : __replace_first_arg<_Tp, _Up> { };
      template<typename _Tp, typename _Up>
 struct __rebind<_Tp, _Up, __void_t<typename _Tp::template rebind<_Up>>>
 { using type = typename _Tp::template rebind<_Up>; };
    public:
      using pointer = _Ptr;
      using element_type
 = __detected_or_t<__get_first_arg_t<_Ptr>, __element_type, _Ptr>;
      using difference_type
 = __detected_or_t<ptrdiff_t, __difference_type, _Ptr>;
      template<typename _Up>
        using rebind = typename __rebind<_Ptr, _Up>::type;
      static _Ptr
      pointer_to(__make_not_void<element_type>& __e)
      { return _Ptr::pointer_to(__e); }
      static_assert(!is_same<element_type, __undefined>::value,
   "pointer type defines element_type or is like SomePointer<T, Args>");
    };
  template<typename _Tp>
    struct pointer_traits<_Tp*>
    {
      typedef _Tp* pointer;
      typedef _Tp element_type;
      typedef ptrdiff_t difference_type;
      template<typename _Up>
        using rebind = _Up*;
      static pointer
      pointer_to(__make_not_void<element_type>& __r) noexcept
      { return std::addressof(__r); }
    };
  template<typename _Ptr, typename _Tp>
    using __ptr_rebind = typename pointer_traits<_Ptr>::template rebind<_Tp>;
  template<typename _Tp>
    constexpr _Tp*
    __to_address(_Tp* __ptr) noexcept
    {
      static_assert(!std::is_function<_Tp>::value, "not a function pointer");
      return __ptr;
    }
  template<typename _Ptr>
    constexpr typename std::pointer_traits<_Ptr>::element_type*
    __to_address(const _Ptr& __ptr)
    { return std::__to_address(__ptr.operator->()); }

}
namespace std
{

  template<typename _Iterator>
    class reverse_iterator
    : public iterator<typename iterator_traits<_Iterator>::iterator_category,
        typename iterator_traits<_Iterator>::value_type,
        typename iterator_traits<_Iterator>::difference_type,
        typename iterator_traits<_Iterator>::pointer,
                      typename iterator_traits<_Iterator>::reference>
    {
    protected:
      _Iterator current;
      typedef iterator_traits<_Iterator> __traits_type;
    public:
      typedef _Iterator iterator_type;
      typedef typename __traits_type::difference_type difference_type;
      typedef typename __traits_type::pointer pointer;
      typedef typename __traits_type::reference reference;
     
      reverse_iterator() : current() { }
      explicit
      reverse_iterator(iterator_type __x) : current(__x) { }
     
      reverse_iterator(const reverse_iterator& __x)
      : current(__x.current) { }
      template<typename _Iter>

        reverse_iterator(const reverse_iterator<_Iter>& __x)
 : current(__x.base()) { }
      iterator_type
      base() const
      { return current; }
      reference
      operator*() const
      {
 _Iterator __tmp = current;
 return *--__tmp;
      }
      pointer
      operator->() const
      { return &(operator*()); }
      reverse_iterator&
      operator++()
      {
 --current;
 return *this;
      }
      reverse_iterator
      operator++(int)
      {
 reverse_iterator __tmp = *this;
 --current;
 return __tmp;
      }
      reverse_iterator&
      operator--()
      {
 ++current;
 return *this;
      }
      reverse_iterator
      operator--(int)
      {
 reverse_iterator __tmp = *this;
 ++current;
 return __tmp;
      }
      reverse_iterator
      operator+(difference_type __n) const
      { return reverse_iterator(current - __n); }
      reverse_iterator&
      operator+=(difference_type __n)
      {
 current -= __n;
 return *this;
      }
      reverse_iterator
      operator-(difference_type __n) const
      { return reverse_iterator(current + __n); }
      reverse_iterator&
      operator-=(difference_type __n)
      {
 current += __n;
 return *this;
      }
      reference
      operator[](difference_type __n) const
      { return *(*this + __n); }
    };
  template<typename _Iterator>
    inline bool
    operator==(const reverse_iterator<_Iterator>& __x,
        const reverse_iterator<_Iterator>& __y)
    { return __x.base() == __y.base(); }
  template<typename _Iterator>
    inline bool
    operator<(const reverse_iterator<_Iterator>& __x,
       const reverse_iterator<_Iterator>& __y)
    { return __y.base() < __x.base(); }
  template<typename _Iterator>
    inline bool
    operator!=(const reverse_iterator<_Iterator>& __x,
        const reverse_iterator<_Iterator>& __y)
    { return !(__x == __y); }
  template<typename _Iterator>
    inline bool
    operator>(const reverse_iterator<_Iterator>& __x,
       const reverse_iterator<_Iterator>& __y)
    { return __y < __x; }
  template<typename _Iterator>
    inline bool
    operator<=(const reverse_iterator<_Iterator>& __x,
        const reverse_iterator<_Iterator>& __y)
    { return !(__y < __x); }
  template<typename _Iterator>
    inline bool
    operator>=(const reverse_iterator<_Iterator>& __x,
        const reverse_iterator<_Iterator>& __y)
    { return !(__x < __y); }
  template<typename _IteratorL, typename _IteratorR>
    inline bool
    operator==(const reverse_iterator<_IteratorL>& __x,
        const reverse_iterator<_IteratorR>& __y)
    { return __x.base() == __y.base(); }
  template<typename _IteratorL, typename _IteratorR>
    inline bool
    operator<(const reverse_iterator<_IteratorL>& __x,
       const reverse_iterator<_IteratorR>& __y)
    { return __y.base() < __x.base(); }
  template<typename _IteratorL, typename _IteratorR>
    inline bool
    operator!=(const reverse_iterator<_IteratorL>& __x,
        const reverse_iterator<_IteratorR>& __y)
    { return !(__x == __y); }
  template<typename _IteratorL, typename _IteratorR>
    inline bool
    operator>(const reverse_iterator<_IteratorL>& __x,
       const reverse_iterator<_IteratorR>& __y)
    { return __y < __x; }
  template<typename _IteratorL, typename _IteratorR>
    inline bool
    operator<=(const reverse_iterator<_IteratorL>& __x,
        const reverse_iterator<_IteratorR>& __y)
    { return !(__y < __x); }
  template<typename _IteratorL, typename _IteratorR>
    inline bool
    operator>=(const reverse_iterator<_IteratorL>& __x,
        const reverse_iterator<_IteratorR>& __y)
    { return !(__x < __y); }
  template<typename _IteratorL, typename _IteratorR>
    inline auto
    operator-(const reverse_iterator<_IteratorL>& __x,
       const reverse_iterator<_IteratorR>& __y)
    -> decltype(__y.base() - __x.base())
    { return __y.base() - __x.base(); }
  template<typename _Iterator>
    inline reverse_iterator<_Iterator>
    operator+(typename reverse_iterator<_Iterator>::difference_type __n,
       const reverse_iterator<_Iterator>& __x)
    { return reverse_iterator<_Iterator>(__x.base() - __n); }
  template<typename _Iterator>
    inline reverse_iterator<_Iterator>
    __make_reverse_iterator(_Iterator __i)
    { return reverse_iterator<_Iterator>(__i); }
  template<typename _Iterator>
    inline reverse_iterator<_Iterator>
    make_reverse_iterator(_Iterator __i)
    { return reverse_iterator<_Iterator>(__i); }
  template<typename _Iterator>
    auto
    __niter_base(reverse_iterator<_Iterator> __it)
    -> decltype(__make_reverse_iterator(__niter_base(__it.base())))
    { return __make_reverse_iterator(__niter_base(__it.base())); }
  template<typename _Iterator>
    struct __is_move_iterator<reverse_iterator<_Iterator> >
      : __is_move_iterator<_Iterator>
    { };
  template<typename _Iterator>
    auto
    __miter_base(reverse_iterator<_Iterator> __it)
    -> decltype(__make_reverse_iterator(__miter_base(__it.base())))
    { return __make_reverse_iterator(__miter_base(__it.base())); }
  template<typename _Container>
    class back_insert_iterator
    : public iterator<output_iterator_tag, void, void, void, void>
    {
    protected:
      _Container* container;
    public:
      typedef _Container container_type;
      explicit
      back_insert_iterator(_Container& __x)
      : container(std::__addressof(__x)) { }
      back_insert_iterator&
      operator=(const typename _Container::value_type& __value)
      {
 container->push_back(__value);
 return *this;
      }
      back_insert_iterator&
      operator=(typename _Container::value_type&& __value)
      {
 container->push_back(std::move(__value));
 return *this;
      }
      back_insert_iterator&
      operator*()
      { return *this; }
      back_insert_iterator&
      operator++()
      { return *this; }
      back_insert_iterator
      operator++(int)
      { return *this; }
    };
  template<typename _Container>
    inline back_insert_iterator<_Container>
    back_inserter(_Container& __x)
    { return back_insert_iterator<_Container>(__x); }
  template<typename _Container>
    class front_insert_iterator
    : public iterator<output_iterator_tag, void, void, void, void>
    {
    protected:
      _Container* container;
    public:
      typedef _Container container_type;
      explicit front_insert_iterator(_Container& __x)
      : container(std::__addressof(__x)) { }
      front_insert_iterator&
      operator=(const typename _Container::value_type& __value)
      {
 container->push_front(__value);
 return *this;
      }
      front_insert_iterator&
      operator=(typename _Container::value_type&& __value)
      {
 container->push_front(std::move(__value));
 return *this;
      }
      front_insert_iterator&
      operator*()
      { return *this; }
      front_insert_iterator&
      operator++()
      { return *this; }
      front_insert_iterator
      operator++(int)
      { return *this; }
    };
  template<typename _Container>
    inline front_insert_iterator<_Container>
    front_inserter(_Container& __x)
    { return front_insert_iterator<_Container>(__x); }
  template<typename _Container>
    class insert_iterator
    : public iterator<output_iterator_tag, void, void, void, void>
    {
    protected:
      _Container* container;
      typename _Container::iterator iter;
    public:
      typedef _Container container_type;
      insert_iterator(_Container& __x, typename _Container::iterator __i)
      : container(std::__addressof(__x)), iter(__i) {}
      insert_iterator&
      operator=(const typename _Container::value_type& __value)
      {
 iter = container->insert(iter, __value);
 ++iter;
 return *this;
      }
      insert_iterator&
      operator=(typename _Container::value_type&& __value)
      {
 iter = container->insert(iter, std::move(__value));
 ++iter;
 return *this;
      }
      insert_iterator&
      operator*()
      { return *this; }
      insert_iterator&
      operator++()
      { return *this; }
      insert_iterator&
      operator++(int)
      { return *this; }
    };
  template<typename _Container, typename _Iterator>
    inline insert_iterator<_Container>
    inserter(_Container& __x, _Iterator __i)
    {
      return insert_iterator<_Container>(__x,
      typename _Container::iterator(__i));
    }

}
namespace __gnu_cxx
{

  using std::iterator_traits;
  using std::iterator;
  template<typename _Iterator, typename _Container>
    class __normal_iterator
    {
    protected:
      _Iterator _M_current;
      typedef iterator_traits<_Iterator> __traits_type;
    public:
      typedef _Iterator iterator_type;
      typedef typename __traits_type::iterator_category iterator_category;
      typedef typename __traits_type::value_type value_type;
      typedef typename __traits_type::difference_type difference_type;
      typedef typename __traits_type::reference reference;
      typedef typename __traits_type::pointer pointer;
      constexpr __normal_iterator() noexcept
      : _M_current(_Iterator()) { }
      explicit
      __normal_iterator(const _Iterator& __i) noexcept
      : _M_current(__i) { }
      template<typename _Iter>
        __normal_iterator(const __normal_iterator<_Iter,
     typename __enable_if<
              (std::__are_same<_Iter, typename _Container::pointer>::__value),
        _Container>::__type>& __i) noexcept
        : _M_current(__i.base()) { }
      reference
      operator*() const noexcept
      { return *_M_current; }
      pointer
      operator->() const noexcept
      { return _M_current; }
      __normal_iterator&
      operator++() noexcept
      {
 ++_M_current;
 return *this;
      }
      __normal_iterator
      operator++(int) noexcept
      { return __normal_iterator(_M_current++); }
      __normal_iterator&
      operator--() noexcept
      {
 --_M_current;
 return *this;
      }
      __normal_iterator
      operator--(int) noexcept
      { return __normal_iterator(_M_current--); }
      reference
      operator[](difference_type __n) const noexcept
      { return _M_current[__n]; }
      __normal_iterator&
      operator+=(difference_type __n) noexcept
      { _M_current += __n; return *this; }
      __normal_iterator
      operator+(difference_type __n) const noexcept
      { return __normal_iterator(_M_current + __n); }
      __normal_iterator&
      operator-=(difference_type __n) noexcept
      { _M_current -= __n; return *this; }
      __normal_iterator
      operator-(difference_type __n) const noexcept
      { return __normal_iterator(_M_current - __n); }
      const _Iterator&
      base() const noexcept
      { return _M_current; }
    };
  template<typename _IteratorL, typename _IteratorR, typename _Container>
    inline bool
    operator==(const __normal_iterator<_IteratorL, _Container>& __lhs,
        const __normal_iterator<_IteratorR, _Container>& __rhs)
    noexcept
    { return __lhs.base() == __rhs.base(); }
  template<typename _Iterator, typename _Container>
    inline bool
    operator==(const __normal_iterator<_Iterator, _Container>& __lhs,
        const __normal_iterator<_Iterator, _Container>& __rhs)
    noexcept
    { return __lhs.base() == __rhs.base(); }
  template<typename _IteratorL, typename _IteratorR, typename _Container>
    inline bool
    operator!=(const __normal_iterator<_IteratorL, _Container>& __lhs,
        const __normal_iterator<_IteratorR, _Container>& __rhs)
    noexcept
    { return __lhs.base() != __rhs.base(); }
  template<typename _Iterator, typename _Container>
    inline bool
    operator!=(const __normal_iterator<_Iterator, _Container>& __lhs,
        const __normal_iterator<_Iterator, _Container>& __rhs)
    noexcept
    { return __lhs.base() != __rhs.base(); }
  template<typename _IteratorL, typename _IteratorR, typename _Container>
    inline bool
    operator<(const __normal_iterator<_IteratorL, _Container>& __lhs,
       const __normal_iterator<_IteratorR, _Container>& __rhs)
    noexcept
    { return __lhs.base() < __rhs.base(); }
  template<typename _Iterator, typename _Container>
    inline bool
    operator<(const __normal_iterator<_Iterator, _Container>& __lhs,
       const __normal_iterator<_Iterator, _Container>& __rhs)
    noexcept
    { return __lhs.base() < __rhs.base(); }
  template<typename _IteratorL, typename _IteratorR, typename _Container>
    inline bool
    operator>(const __normal_iterator<_IteratorL, _Container>& __lhs,
       const __normal_iterator<_IteratorR, _Container>& __rhs)
    noexcept
    { return __lhs.base() > __rhs.base(); }
  template<typename _Iterator, typename _Container>
    inline bool
    operator>(const __normal_iterator<_Iterator, _Container>& __lhs,
       const __normal_iterator<_Iterator, _Container>& __rhs)
    noexcept
    { return __lhs.base() > __rhs.base(); }
  template<typename _IteratorL, typename _IteratorR, typename _Container>
    inline bool
    operator<=(const __normal_iterator<_IteratorL, _Container>& __lhs,
        const __normal_iterator<_IteratorR, _Container>& __rhs)
    noexcept
    { return __lhs.base() <= __rhs.base(); }
  template<typename _Iterator, typename _Container>
    inline bool
    operator<=(const __normal_iterator<_Iterator, _Container>& __lhs,
        const __normal_iterator<_Iterator, _Container>& __rhs)
    noexcept
    { return __lhs.base() <= __rhs.base(); }
  template<typename _IteratorL, typename _IteratorR, typename _Container>
    inline bool
    operator>=(const __normal_iterator<_IteratorL, _Container>& __lhs,
        const __normal_iterator<_IteratorR, _Container>& __rhs)
    noexcept
    { return __lhs.base() >= __rhs.base(); }
  template<typename _Iterator, typename _Container>
    inline bool
    operator>=(const __normal_iterator<_Iterator, _Container>& __lhs,
        const __normal_iterator<_Iterator, _Container>& __rhs)
    noexcept
    { return __lhs.base() >= __rhs.base(); }
  template<typename _IteratorL, typename _IteratorR, typename _Container>
    inline auto
    operator-(const __normal_iterator<_IteratorL, _Container>& __lhs,
       const __normal_iterator<_IteratorR, _Container>& __rhs) noexcept
    -> decltype(__lhs.base() - __rhs.base())
    { return __lhs.base() - __rhs.base(); }
  template<typename _Iterator, typename _Container>
    inline typename __normal_iterator<_Iterator, _Container>::difference_type
    operator-(const __normal_iterator<_Iterator, _Container>& __lhs,
       const __normal_iterator<_Iterator, _Container>& __rhs)
    noexcept
    { return __lhs.base() - __rhs.base(); }
  template<typename _Iterator, typename _Container>
    inline __normal_iterator<_Iterator, _Container>
    operator+(typename __normal_iterator<_Iterator, _Container>::difference_type
       __n, const __normal_iterator<_Iterator, _Container>& __i)
    noexcept
    { return __normal_iterator<_Iterator, _Container>(__i.base() + __n); }

}
namespace std
{

  template<typename _Iterator, typename _Container>
    _Iterator
    __niter_base(__gnu_cxx::__normal_iterator<_Iterator, _Container> __it)
    { return __it.base(); }
  template<typename _Iterator>
    class move_iterator
    {
    protected:
      _Iterator _M_current;
      typedef iterator_traits<_Iterator> __traits_type;
      typedef typename __traits_type::reference __base_ref;
    public:
      typedef _Iterator iterator_type;
      typedef typename __traits_type::iterator_category iterator_category;
      typedef typename __traits_type::value_type value_type;
      typedef typename __traits_type::difference_type difference_type;
      typedef _Iterator pointer;
      typedef typename conditional<is_reference<__base_ref>::value,
    typename remove_reference<__base_ref>::type&&,
    __base_ref>::type reference;
     
      move_iterator()
      : _M_current() { }
      explicit
      move_iterator(iterator_type __i)
      : _M_current(__i) { }
      template<typename _Iter>

 move_iterator(const move_iterator<_Iter>& __i)
 : _M_current(__i.base()) { }
      iterator_type
      base() const
      { return _M_current; }
      reference
      operator*() const
      { return static_cast<reference>(*_M_current); }
      pointer
      operator->() const
      { return _M_current; }
      move_iterator&
      operator++()
      {
 ++_M_current;
 return *this;
      }
      move_iterator
      operator++(int)
      {
 move_iterator __tmp = *this;
 ++_M_current;
 return __tmp;
      }
      move_iterator&
      operator--()
      {
 --_M_current;
 return *this;
      }
      move_iterator
      operator--(int)
      {
 move_iterator __tmp = *this;
 --_M_current;
 return __tmp;
      }
      move_iterator
      operator+(difference_type __n) const
      { return move_iterator(_M_current + __n); }
      move_iterator&
      operator+=(difference_type __n)
      {
 _M_current += __n;
 return *this;
      }
      move_iterator
      operator-(difference_type __n) const
      { return move_iterator(_M_current - __n); }
      move_iterator&
      operator-=(difference_type __n)
      {
 _M_current -= __n;
 return *this;
      }
      reference
      operator[](difference_type __n) const
      { return std::move(_M_current[__n]); }
    };
  template<typename _IteratorL, typename _IteratorR>
    inline bool
    operator==(const move_iterator<_IteratorL>& __x,
        const move_iterator<_IteratorR>& __y)
    { return __x.base() == __y.base(); }
  template<typename _Iterator>
    inline bool
    operator==(const move_iterator<_Iterator>& __x,
        const move_iterator<_Iterator>& __y)
    { return __x.base() == __y.base(); }
  template<typename _IteratorL, typename _IteratorR>
    inline bool
    operator!=(const move_iterator<_IteratorL>& __x,
        const move_iterator<_IteratorR>& __y)
    { return !(__x == __y); }
  template<typename _Iterator>
    inline bool
    operator!=(const move_iterator<_Iterator>& __x,
        const move_iterator<_Iterator>& __y)
    { return !(__x == __y); }
  template<typename _IteratorL, typename _IteratorR>
    inline bool
    operator<(const move_iterator<_IteratorL>& __x,
       const move_iterator<_IteratorR>& __y)
    { return __x.base() < __y.base(); }
  template<typename _Iterator>
    inline bool
    operator<(const move_iterator<_Iterator>& __x,
       const move_iterator<_Iterator>& __y)
    { return __x.base() < __y.base(); }
  template<typename _IteratorL, typename _IteratorR>
    inline bool
    operator<=(const move_iterator<_IteratorL>& __x,
        const move_iterator<_IteratorR>& __y)
    { return !(__y < __x); }
  template<typename _Iterator>
    inline bool
    operator<=(const move_iterator<_Iterator>& __x,
        const move_iterator<_Iterator>& __y)
    { return !(__y < __x); }
  template<typename _IteratorL, typename _IteratorR>
    inline bool
    operator>(const move_iterator<_IteratorL>& __x,
       const move_iterator<_IteratorR>& __y)
    { return __y < __x; }
  template<typename _Iterator>
    inline bool
    operator>(const move_iterator<_Iterator>& __x,
       const move_iterator<_Iterator>& __y)
    { return __y < __x; }
  template<typename _IteratorL, typename _IteratorR>
    inline bool
    operator>=(const move_iterator<_IteratorL>& __x,
        const move_iterator<_IteratorR>& __y)
    { return !(__x < __y); }
  template<typename _Iterator>
    inline bool
    operator>=(const move_iterator<_Iterator>& __x,
        const move_iterator<_Iterator>& __y)
    { return !(__x < __y); }
  template<typename _IteratorL, typename _IteratorR>
    inline auto
    operator-(const move_iterator<_IteratorL>& __x,
       const move_iterator<_IteratorR>& __y)
    -> decltype(__x.base() - __y.base())
    { return __x.base() - __y.base(); }
  template<typename _Iterator>
    inline move_iterator<_Iterator>
    operator+(typename move_iterator<_Iterator>::difference_type __n,
       const move_iterator<_Iterator>& __x)
    { return __x + __n; }
  template<typename _Iterator>
    inline move_iterator<_Iterator>
    make_move_iterator(_Iterator __i)
    { return move_iterator<_Iterator>(__i); }
  template<typename _Iterator, typename _ReturnType
    = typename conditional<__move_if_noexcept_cond
      <typename iterator_traits<_Iterator>::value_type>::value,
                _Iterator, move_iterator<_Iterator>>::type>
    inline _ReturnType
    __make_move_if_noexcept_iterator(_Iterator __i)
    { return _ReturnType(__i); }
  template<typename _Tp, typename _ReturnType
    = typename conditional<__move_if_noexcept_cond<_Tp>::value,
      const _Tp*, move_iterator<_Tp*>>::type>
    inline _ReturnType
    __make_move_if_noexcept_iterator(_Tp* __i)
    { return _ReturnType(__i); }
  template<typename _Iterator>
    auto
    __niter_base(move_iterator<_Iterator> __it)
    -> decltype(make_move_iterator(__niter_base(__it.base())))
    { return make_move_iterator(__niter_base(__it.base())); }
  template<typename _Iterator>
    struct __is_move_iterator<move_iterator<_Iterator> >
    {
      enum { __value = 1 };
      typedef __true_type __type;
    };
  template<typename _Iterator>
    auto
    __miter_base(move_iterator<_Iterator> __it)
    -> decltype(__miter_base(__it.base()))
    { return __miter_base(__it.base()); }

}
namespace std
{
  namespace __debug { }
}
namespace __gnu_debug
{
  using namespace std::__debug;
}
namespace __gnu_cxx
{
namespace __ops
{
  struct _Iter_less_iter
  {
    template<typename _Iterator1, typename _Iterator2>
      constexpr
      bool
      operator()(_Iterator1 __it1, _Iterator2 __it2) const
      { return *__it1 < *__it2; }
  };
  constexpr
  inline _Iter_less_iter
  __iter_less_iter()
  { return _Iter_less_iter(); }
  struct _Iter_less_val
  {
    constexpr _Iter_less_val() = default;
    explicit
    _Iter_less_val(_Iter_less_iter) { }
    template<typename _Iterator, typename _Value>
      bool
      operator()(_Iterator __it, _Value& __val) const
      { return *__it < __val; }
  };
  inline _Iter_less_val
  __iter_less_val()
  { return _Iter_less_val(); }
  inline _Iter_less_val
  __iter_comp_val(_Iter_less_iter)
  { return _Iter_less_val(); }
  struct _Val_less_iter
  {
    constexpr _Val_less_iter() = default;
    explicit
    _Val_less_iter(_Iter_less_iter) { }
    template<typename _Value, typename _Iterator>
      bool
      operator()(_Value& __val, _Iterator __it) const
      { return __val < *__it; }
  };
  inline _Val_less_iter
  __val_less_iter()
  { return _Val_less_iter(); }
  inline _Val_less_iter
  __val_comp_iter(_Iter_less_iter)
  { return _Val_less_iter(); }
  struct _Iter_equal_to_iter
  {
    template<typename _Iterator1, typename _Iterator2>
      bool
      operator()(_Iterator1 __it1, _Iterator2 __it2) const
      { return *__it1 == *__it2; }
  };
  inline _Iter_equal_to_iter
  __iter_equal_to_iter()
  { return _Iter_equal_to_iter(); }
  struct _Iter_equal_to_val
  {
    template<typename _Iterator, typename _Value>
      bool
      operator()(_Iterator __it, _Value& __val) const
      { return *__it == __val; }
  };
  inline _Iter_equal_to_val
  __iter_equal_to_val()
  { return _Iter_equal_to_val(); }
  inline _Iter_equal_to_val
  __iter_comp_val(_Iter_equal_to_iter)
  { return _Iter_equal_to_val(); }
  template<typename _Compare>
    struct _Iter_comp_iter
    {
      _Compare _M_comp;
      explicit constexpr
      _Iter_comp_iter(_Compare __comp)
 : _M_comp(std::move(__comp))
      { }
      template<typename _Iterator1, typename _Iterator2>
        constexpr
        bool
        operator()(_Iterator1 __it1, _Iterator2 __it2)
        { return bool(_M_comp(*__it1, *__it2)); }
    };
  template<typename _Compare>
    constexpr
    inline _Iter_comp_iter<_Compare>
    __iter_comp_iter(_Compare __comp)
    { return _Iter_comp_iter<_Compare>(std::move(__comp)); }
  template<typename _Compare>
    struct _Iter_comp_val
    {
      _Compare _M_comp;
      explicit
      _Iter_comp_val(_Compare __comp)
 : _M_comp(std::move(__comp))
      { }
      explicit
      _Iter_comp_val(const _Iter_comp_iter<_Compare>& __comp)
 : _M_comp(__comp._M_comp)
      { }
      explicit
      _Iter_comp_val(_Iter_comp_iter<_Compare>&& __comp)
 : _M_comp(std::move(__comp._M_comp))
      { }
      template<typename _Iterator, typename _Value>
 bool
 operator()(_Iterator __it, _Value& __val)
 { return bool(_M_comp(*__it, __val)); }
    };
  template<typename _Compare>
   inline _Iter_comp_val<_Compare>
    __iter_comp_val(_Compare __comp)
    { return _Iter_comp_val<_Compare>(std::move(__comp)); }
  template<typename _Compare>
    inline _Iter_comp_val<_Compare>
    __iter_comp_val(_Iter_comp_iter<_Compare> __comp)
    { return _Iter_comp_val<_Compare>(std::move(__comp)); }
  template<typename _Compare>
    struct _Val_comp_iter
    {
      _Compare _M_comp;
      explicit
      _Val_comp_iter(_Compare __comp)
 : _M_comp(std::move(__comp))
      { }
      explicit
      _Val_comp_iter(const _Iter_comp_iter<_Compare>& __comp)
 : _M_comp(__comp._M_comp)
      { }
      explicit
      _Val_comp_iter(_Iter_comp_iter<_Compare>&& __comp)
 : _M_comp(std::move(__comp._M_comp))
      { }
      template<typename _Value, typename _Iterator>
 bool
 operator()(_Value& __val, _Iterator __it)
 { return bool(_M_comp(__val, *__it)); }
    };
  template<typename _Compare>
    inline _Val_comp_iter<_Compare>
    __val_comp_iter(_Compare __comp)
    { return _Val_comp_iter<_Compare>(std::move(__comp)); }
  template<typename _Compare>
    inline _Val_comp_iter<_Compare>
    __val_comp_iter(_Iter_comp_iter<_Compare> __comp)
    { return _Val_comp_iter<_Compare>(std::move(__comp)); }
  template<typename _Value>
    struct _Iter_equals_val
    {
      _Value& _M_value;
      explicit
      _Iter_equals_val(_Value& __value)
 : _M_value(__value)
      { }
      template<typename _Iterator>
 bool
 operator()(_Iterator __it)
 { return *__it == _M_value; }
    };
  template<typename _Value>
    inline _Iter_equals_val<_Value>
    __iter_equals_val(_Value& __val)
    { return _Iter_equals_val<_Value>(__val); }
  template<typename _Iterator1>
    struct _Iter_equals_iter
    {
      _Iterator1 _M_it1;
      explicit
      _Iter_equals_iter(_Iterator1 __it1)
 : _M_it1(__it1)
      { }
      template<typename _Iterator2>
 bool
 operator()(_Iterator2 __it2)
 { return *__it2 == *_M_it1; }
    };
  template<typename _Iterator>
    inline _Iter_equals_iter<_Iterator>
    __iter_comp_iter(_Iter_equal_to_iter, _Iterator __it)
    { return _Iter_equals_iter<_Iterator>(__it); }
  template<typename _Predicate>
    struct _Iter_pred
    {
      _Predicate _M_pred;
      explicit
      _Iter_pred(_Predicate __pred)
 : _M_pred(std::move(__pred))
      { }
      template<typename _Iterator>
 bool
 operator()(_Iterator __it)
 { return bool(_M_pred(*__it)); }
    };
  template<typename _Predicate>
    inline _Iter_pred<_Predicate>
    __pred_iter(_Predicate __pred)
    { return _Iter_pred<_Predicate>(std::move(__pred)); }
  template<typename _Compare, typename _Value>
    struct _Iter_comp_to_val
    {
      _Compare _M_comp;
      _Value& _M_value;
      _Iter_comp_to_val(_Compare __comp, _Value& __value)
 : _M_comp(std::move(__comp)), _M_value(__value)
      { }
      template<typename _Iterator>
 bool
 operator()(_Iterator __it)
 { return bool(_M_comp(*__it, _M_value)); }
    };
  template<typename _Compare, typename _Value>
    _Iter_comp_to_val<_Compare, _Value>
    __iter_comp_val(_Compare __comp, _Value &__val)
    {
      return _Iter_comp_to_val<_Compare, _Value>(std::move(__comp), __val);
    }
  template<typename _Compare, typename _Iterator1>
    struct _Iter_comp_to_iter
    {
      _Compare _M_comp;
      _Iterator1 _M_it1;
      _Iter_comp_to_iter(_Compare __comp, _Iterator1 __it1)
 : _M_comp(std::move(__comp)), _M_it1(__it1)
      { }
      template<typename _Iterator2>
 bool
 operator()(_Iterator2 __it2)
 { return bool(_M_comp(*__it2, *_M_it1)); }
    };
  template<typename _Compare, typename _Iterator>
    inline _Iter_comp_to_iter<_Compare, _Iterator>
    __iter_comp_iter(_Iter_comp_iter<_Compare> __comp, _Iterator __it)
    {
      return _Iter_comp_to_iter<_Compare, _Iterator>(
   std::move(__comp._M_comp), __it);
    }
  template<typename _Predicate>
    struct _Iter_negate
    {
      _Predicate _M_pred;
      explicit
      _Iter_negate(_Predicate __pred)
 : _M_pred(std::move(__pred))
      { }
      template<typename _Iterator>
 bool
 operator()(_Iterator __it)
 { return !bool(_M_pred(*__it)); }
    };
  template<typename _Predicate>
    inline _Iter_negate<_Predicate>
    __negate(_Iter_pred<_Predicate> __pred)
    { return _Iter_negate<_Predicate>(std::move(__pred._M_pred)); }
}
}
namespace std
{

  template<typename _ForwardIterator1, typename _ForwardIterator2>
    inline void
    iter_swap(_ForwardIterator1 __a, _ForwardIterator2 __b)
    {
     
     
      swap(*__a, *__b);
    }
  template<typename _ForwardIterator1, typename _ForwardIterator2>
    _ForwardIterator2
    swap_ranges(_ForwardIterator1 __first1, _ForwardIterator1 __last1,
  _ForwardIterator2 __first2)
    {
     
     
      ;
      for (; __first1 != __last1; ++__first1, (void)++__first2)
 std::iter_swap(__first1, __first2);
      return __first2;
    }
  template<typename _Tp>
    constexpr
    inline const _Tp&
    min(const _Tp& __a, const _Tp& __b)
    {
     
      if (__b < __a)
 return __b;
      return __a;
    }
  template<typename _Tp>
    constexpr
    inline const _Tp&
    max(const _Tp& __a, const _Tp& __b)
    {
     
      if (__a < __b)
 return __b;
      return __a;
    }
  template<typename _Tp, typename _Compare>
    constexpr
    inline const _Tp&
    min(const _Tp& __a, const _Tp& __b, _Compare __comp)
    {
      if (__comp(__b, __a))
 return __b;
      return __a;
    }
  template<typename _Tp, typename _Compare>
    constexpr
    inline const _Tp&
    max(const _Tp& __a, const _Tp& __b, _Compare __comp)
    {
      if (__comp(__a, __b))
 return __b;
      return __a;
    }
  template<typename _Iterator>
    inline _Iterator
    __niter_base(_Iterator __it)
    { return __it; }
  template<bool, bool, typename>
    struct __copy_move
    {
      template<typename _II, typename _OI>
 static _OI
 __copy_m(_II __first, _II __last, _OI __result)
 {
   for (; __first != __last; ++__result, (void)++__first)
     *__result = *__first;
   return __result;
 }
    };
  template<typename _Category>
    struct __copy_move<true, false, _Category>
    {
      template<typename _II, typename _OI>
 static _OI
 __copy_m(_II __first, _II __last, _OI __result)
 {
   for (; __first != __last; ++__result, (void)++__first)
     *__result = std::move(*__first);
   return __result;
 }
    };
  template<>
    struct __copy_move<false, false, random_access_iterator_tag>
    {
      template<typename _II, typename _OI>
 static _OI
 __copy_m(_II __first, _II __last, _OI __result)
 {
   typedef typename iterator_traits<_II>::difference_type _Distance;
   for(_Distance __n = __last - __first; __n > 0; --__n)
     {
       *__result = *__first;
       ++__first;
       ++__result;
     }
   return __result;
 }
    };
  template<>
    struct __copy_move<true, false, random_access_iterator_tag>
    {
      template<typename _II, typename _OI>
 static _OI
 __copy_m(_II __first, _II __last, _OI __result)
 {
   typedef typename iterator_traits<_II>::difference_type _Distance;
   for(_Distance __n = __last - __first; __n > 0; --__n)
     {
       *__result = std::move(*__first);
       ++__first;
       ++__result;
     }
   return __result;
 }
    };
  template<bool _IsMove>
    struct __copy_move<_IsMove, true, random_access_iterator_tag>
    {
      template<typename _Tp>
 static _Tp*
 __copy_m(const _Tp* __first, const _Tp* __last, _Tp* __result)
 {
   using __assignable = conditional<_IsMove,
        is_move_assignable<_Tp>,
        is_copy_assignable<_Tp>>;
   static_assert( __assignable::type::value, "type is not assignable" );
   const ptrdiff_t _Num = __last - __first;
   if (_Num)
     __builtin_memmove(__result, __first, sizeof(_Tp) * _Num);
   return __result + _Num;
 }
    };
  template<bool _IsMove, typename _II, typename _OI>
    inline _OI
    __copy_move_a(_II __first, _II __last, _OI __result)
    {
      typedef typename iterator_traits<_II>::value_type _ValueTypeI;
      typedef typename iterator_traits<_OI>::value_type _ValueTypeO;
      typedef typename iterator_traits<_II>::iterator_category _Category;
      const bool __simple = (__is_trivial(_ValueTypeI)
        && __is_pointer<_II>::__value
        && __is_pointer<_OI>::__value
        && __are_same<_ValueTypeI, _ValueTypeO>::__value);
      return std::__copy_move<_IsMove, __simple,
         _Category>::__copy_m(__first, __last, __result);
    }
  template<typename _CharT>
    struct char_traits;
  template<typename _CharT, typename _Traits>
    class istreambuf_iterator;
  template<typename _CharT, typename _Traits>
    class ostreambuf_iterator;
  template<bool _IsMove, typename _CharT>
    typename __gnu_cxx::__enable_if<__is_char<_CharT>::__value,
      ostreambuf_iterator<_CharT, char_traits<_CharT> > >::__type
    __copy_move_a2(_CharT*, _CharT*,
     ostreambuf_iterator<_CharT, char_traits<_CharT> >);
  template<bool _IsMove, typename _CharT>
    typename __gnu_cxx::__enable_if<__is_char<_CharT>::__value,
      ostreambuf_iterator<_CharT, char_traits<_CharT> > >::__type
    __copy_move_a2(const _CharT*, const _CharT*,
     ostreambuf_iterator<_CharT, char_traits<_CharT> >);
  template<bool _IsMove, typename _CharT>
    typename __gnu_cxx::__enable_if<__is_char<_CharT>::__value,
        _CharT*>::__type
    __copy_move_a2(istreambuf_iterator<_CharT, char_traits<_CharT> >,
     istreambuf_iterator<_CharT, char_traits<_CharT> >, _CharT*);
  template<bool _IsMove, typename _II, typename _OI>
    inline _OI
    __copy_move_a2(_II __first, _II __last, _OI __result)
    {
      return _OI(std::__copy_move_a<_IsMove>(std::__niter_base(__first),
          std::__niter_base(__last),
          std::__niter_base(__result)));
    }
  template<typename _II, typename _OI>
    inline _OI
    copy(_II __first, _II __last, _OI __result)
    {
     
     
      ;
      return (std::__copy_move_a2<__is_move_iterator<_II>::__value>
       (std::__miter_base(__first), std::__miter_base(__last),
        __result));
    }
  template<typename _II, typename _OI>
    inline _OI
    move(_II __first, _II __last, _OI __result)
    {
     
     
      ;
      return std::__copy_move_a2<true>(std::__miter_base(__first),
           std::__miter_base(__last), __result);
    }
  template<bool, bool, typename>
    struct __copy_move_backward
    {
      template<typename _BI1, typename _BI2>
 static _BI2
 __copy_move_b(_BI1 __first, _BI1 __last, _BI2 __result)
 {
   while (__first != __last)
     *--__result = *--__last;
   return __result;
 }
    };
  template<typename _Category>
    struct __copy_move_backward<true, false, _Category>
    {
      template<typename _BI1, typename _BI2>
 static _BI2
 __copy_move_b(_BI1 __first, _BI1 __last, _BI2 __result)
 {
   while (__first != __last)
     *--__result = std::move(*--__last);
   return __result;
 }
    };
  template<>
    struct __copy_move_backward<false, false, random_access_iterator_tag>
    {
      template<typename _BI1, typename _BI2>
 static _BI2
 __copy_move_b(_BI1 __first, _BI1 __last, _BI2 __result)
 {
   typename iterator_traits<_BI1>::difference_type __n;
   for (__n = __last - __first; __n > 0; --__n)
     *--__result = *--__last;
   return __result;
 }
    };
  template<>
    struct __copy_move_backward<true, false, random_access_iterator_tag>
    {
      template<typename _BI1, typename _BI2>
 static _BI2
 __copy_move_b(_BI1 __first, _BI1 __last, _BI2 __result)
 {
   typename iterator_traits<_BI1>::difference_type __n;
   for (__n = __last - __first; __n > 0; --__n)
     *--__result = std::move(*--__last);
   return __result;
 }
    };
  template<bool _IsMove>
    struct __copy_move_backward<_IsMove, true, random_access_iterator_tag>
    {
      template<typename _Tp>
 static _Tp*
 __copy_move_b(const _Tp* __first, const _Tp* __last, _Tp* __result)
 {
   using __assignable = conditional<_IsMove,
        is_move_assignable<_Tp>,
        is_copy_assignable<_Tp>>;
   static_assert( __assignable::type::value, "type is not assignable" );
   const ptrdiff_t _Num = __last - __first;
   if (_Num)
     __builtin_memmove(__result - _Num, __first, sizeof(_Tp) * _Num);
   return __result - _Num;
 }
    };
  template<bool _IsMove, typename _BI1, typename _BI2>
    inline _BI2
    __copy_move_backward_a(_BI1 __first, _BI1 __last, _BI2 __result)
    {
      typedef typename iterator_traits<_BI1>::value_type _ValueType1;
      typedef typename iterator_traits<_BI2>::value_type _ValueType2;
      typedef typename iterator_traits<_BI1>::iterator_category _Category;
      const bool __simple = (__is_trivial(_ValueType1)
        && __is_pointer<_BI1>::__value
        && __is_pointer<_BI2>::__value
        && __are_same<_ValueType1, _ValueType2>::__value);
      return std::__copy_move_backward<_IsMove, __simple,
           _Category>::__copy_move_b(__first,
         __last,
         __result);
    }
  template<bool _IsMove, typename _BI1, typename _BI2>
    inline _BI2
    __copy_move_backward_a2(_BI1 __first, _BI1 __last, _BI2 __result)
    {
      return _BI2(std::__copy_move_backward_a<_IsMove>
    (std::__niter_base(__first), std::__niter_base(__last),
     std::__niter_base(__result)));
    }
  template<typename _BI1, typename _BI2>
    inline _BI2
    copy_backward(_BI1 __first, _BI1 __last, _BI2 __result)
    {
     
     
     
      ;
      return (std::__copy_move_backward_a2<__is_move_iterator<_BI1>::__value>
       (std::__miter_base(__first), std::__miter_base(__last),
        __result));
    }
  template<typename _BI1, typename _BI2>
    inline _BI2
    move_backward(_BI1 __first, _BI1 __last, _BI2 __result)
    {
     
     
     
      ;
      return std::__copy_move_backward_a2<true>(std::__miter_base(__first),
      std::__miter_base(__last),
      __result);
    }
  template<typename _ForwardIterator, typename _Tp>
    inline typename
    __gnu_cxx::__enable_if<!__is_scalar<_Tp>::__value, void>::__type
    __fill_a(_ForwardIterator __first, _ForwardIterator __last,
       const _Tp& __value)
    {
      for (; __first != __last; ++__first)
 *__first = __value;
    }
  template<typename _ForwardIterator, typename _Tp>
    inline typename
    __gnu_cxx::__enable_if<__is_scalar<_Tp>::__value, void>::__type
    __fill_a(_ForwardIterator __first, _ForwardIterator __last,
      const _Tp& __value)
    {
      const _Tp __tmp = __value;
      for (; __first != __last; ++__first)
 *__first = __tmp;
    }
  template<typename _Tp>
    inline typename
    __gnu_cxx::__enable_if<__is_byte<_Tp>::__value, void>::__type
    __fill_a(_Tp* __first, _Tp* __last, const _Tp& __c)
    {
      const _Tp __tmp = __c;
      if (const size_t __len = __last - __first)
 __builtin_memset(__first, static_cast<unsigned char>(__tmp), __len);
    }
  template<typename _ForwardIterator, typename _Tp>
    inline void
    fill(_ForwardIterator __first, _ForwardIterator __last, const _Tp& __value)
    {
     
      ;
      std::__fill_a(std::__niter_base(__first), std::__niter_base(__last),
      __value);
    }
  template<typename _OutputIterator, typename _Size, typename _Tp>
    inline typename
    __gnu_cxx::__enable_if<!__is_scalar<_Tp>::__value, _OutputIterator>::__type
    __fill_n_a(_OutputIterator __first, _Size __n, const _Tp& __value)
    {
      for (__decltype(__n + 0) __niter = __n;
    __niter > 0; --__niter, (void) ++__first)
 *__first = __value;
      return __first;
    }
  template<typename _OutputIterator, typename _Size, typename _Tp>
    inline typename
    __gnu_cxx::__enable_if<__is_scalar<_Tp>::__value, _OutputIterator>::__type
    __fill_n_a(_OutputIterator __first, _Size __n, const _Tp& __value)
    {
      const _Tp __tmp = __value;
      for (__decltype(__n + 0) __niter = __n;
    __niter > 0; --__niter, (void) ++__first)
 *__first = __tmp;
      return __first;
    }
  template<typename _Size, typename _Tp>
    inline typename
    __gnu_cxx::__enable_if<__is_byte<_Tp>::__value, _Tp*>::__type
    __fill_n_a(_Tp* __first, _Size __n, const _Tp& __c)
    {
      std::__fill_a(__first, __first + __n, __c);
      return __first + __n;
    }
  template<typename _OI, typename _Size, typename _Tp>
    inline _OI
    fill_n(_OI __first, _Size __n, const _Tp& __value)
    {
     
      return _OI(std::__fill_n_a(std::__niter_base(__first), __n, __value));
    }
  template<bool _BoolType>
    struct __equal
    {
      template<typename _II1, typename _II2>
 static bool
 equal(_II1 __first1, _II1 __last1, _II2 __first2)
 {
   for (; __first1 != __last1; ++__first1, (void) ++__first2)
     if (!(*__first1 == *__first2))
       return false;
   return true;
 }
    };
  template<>
    struct __equal<true>
    {
      template<typename _Tp>
 static bool
 equal(const _Tp* __first1, const _Tp* __last1, const _Tp* __first2)
 {
   if (const size_t __len = (__last1 - __first1))
     return !__builtin_memcmp(__first1, __first2, sizeof(_Tp) * __len);
   return true;
 }
    };
  template<typename _II1, typename _II2>
    inline bool
    __equal_aux(_II1 __first1, _II1 __last1, _II2 __first2)
    {
      typedef typename iterator_traits<_II1>::value_type _ValueType1;
      typedef typename iterator_traits<_II2>::value_type _ValueType2;
      const bool __simple = ((__is_integer<_ValueType1>::__value
         || __is_pointer<_ValueType1>::__value)
        && __is_pointer<_II1>::__value
        && __is_pointer<_II2>::__value
        && __are_same<_ValueType1, _ValueType2>::__value);
      return std::__equal<__simple>::equal(__first1, __last1, __first2);
    }
  template<typename, typename>
    struct __lc_rai
    {
      template<typename _II1, typename _II2>
 static _II1
 __newlast1(_II1, _II1 __last1, _II2, _II2)
 { return __last1; }
      template<typename _II>
 static bool
 __cnd2(_II __first, _II __last)
 { return __first != __last; }
    };
  template<>
    struct __lc_rai<random_access_iterator_tag, random_access_iterator_tag>
    {
      template<typename _RAI1, typename _RAI2>
 static _RAI1
 __newlast1(_RAI1 __first1, _RAI1 __last1,
     _RAI2 __first2, _RAI2 __last2)
 {
   const typename iterator_traits<_RAI1>::difference_type
     __diff1 = __last1 - __first1;
   const typename iterator_traits<_RAI2>::difference_type
     __diff2 = __last2 - __first2;
   return __diff2 < __diff1 ? __first1 + __diff2 : __last1;
 }
      template<typename _RAI>
 static bool
 __cnd2(_RAI, _RAI)
 { return true; }
    };
  template<typename _II1, typename _II2, typename _Compare>
    bool
    __lexicographical_compare_impl(_II1 __first1, _II1 __last1,
       _II2 __first2, _II2 __last2,
       _Compare __comp)
    {
      typedef typename iterator_traits<_II1>::iterator_category _Category1;
      typedef typename iterator_traits<_II2>::iterator_category _Category2;
      typedef std::__lc_rai<_Category1, _Category2> __rai_type;
      __last1 = __rai_type::__newlast1(__first1, __last1, __first2, __last2);
      for (; __first1 != __last1 && __rai_type::__cnd2(__first2, __last2);
    ++__first1, (void)++__first2)
 {
   if (__comp(__first1, __first2))
     return true;
   if (__comp(__first2, __first1))
     return false;
 }
      return __first1 == __last1 && __first2 != __last2;
    }
  template<bool _BoolType>
    struct __lexicographical_compare
    {
      template<typename _II1, typename _II2>
 static bool __lc(_II1, _II1, _II2, _II2);
    };
  template<bool _BoolType>
    template<typename _II1, typename _II2>
      bool
      __lexicographical_compare<_BoolType>::
      __lc(_II1 __first1, _II1 __last1, _II2 __first2, _II2 __last2)
      {
 return std::__lexicographical_compare_impl(__first1, __last1,
         __first2, __last2,
     __gnu_cxx::__ops::__iter_less_iter());
      }
  template<>
    struct __lexicographical_compare<true>
    {
      template<typename _Tp, typename _Up>
 static bool
 __lc(const _Tp* __first1, const _Tp* __last1,
      const _Up* __first2, const _Up* __last2)
 {
   const size_t __len1 = __last1 - __first1;
   const size_t __len2 = __last2 - __first2;
   if (const size_t __len = std::min(__len1, __len2))
     if (int __result = __builtin_memcmp(__first1, __first2, __len))
       return __result < 0;
   return __len1 < __len2;
 }
    };
  template<typename _II1, typename _II2>
    inline bool
    __lexicographical_compare_aux(_II1 __first1, _II1 __last1,
      _II2 __first2, _II2 __last2)
    {
      typedef typename iterator_traits<_II1>::value_type _ValueType1;
      typedef typename iterator_traits<_II2>::value_type _ValueType2;
      const bool __simple =
 (__is_byte<_ValueType1>::__value && __is_byte<_ValueType2>::__value
  && !__gnu_cxx::__numeric_traits<_ValueType1>::__is_signed
  && !__gnu_cxx::__numeric_traits<_ValueType2>::__is_signed
  && __is_pointer<_II1>::__value
  && __is_pointer<_II2>::__value);
      return std::__lexicographical_compare<__simple>::__lc(__first1, __last1,
           __first2, __last2);
    }
  template<typename _ForwardIterator, typename _Tp, typename _Compare>
    _ForwardIterator
    __lower_bound(_ForwardIterator __first, _ForwardIterator __last,
    const _Tp& __val, _Compare __comp)
    {
      typedef typename iterator_traits<_ForwardIterator>::difference_type
 _DistanceType;
      _DistanceType __len = std::distance(__first, __last);
      while (__len > 0)
 {
   _DistanceType __half = __len >> 1;
   _ForwardIterator __middle = __first;
   std::advance(__middle, __half);
   if (__comp(__middle, __val))
     {
       __first = __middle;
       ++__first;
       __len = __len - __half - 1;
     }
   else
     __len = __half;
 }
      return __first;
    }
  template<typename _ForwardIterator, typename _Tp>
    inline _ForwardIterator
    lower_bound(_ForwardIterator __first, _ForwardIterator __last,
  const _Tp& __val)
    {
     
     
      ;
      return std::__lower_bound(__first, __last, __val,
    __gnu_cxx::__ops::__iter_less_val());
    }
  inline constexpr int
  __lg(int __n)
  { return sizeof(int) * 8 - 1 - __builtin_clz(__n); }
  inline constexpr unsigned
  __lg(unsigned __n)
  { return sizeof(int) * 8 - 1 - __builtin_clz(__n); }
  inline constexpr long
  __lg(long __n)
  { return sizeof(long) * 8 - 1 - __builtin_clzl(__n); }
  inline constexpr unsigned long
  __lg(unsigned long __n)
  { return sizeof(long) * 8 - 1 - __builtin_clzl(__n); }
  inline constexpr long long
  __lg(long long __n)
  { return sizeof(long long) * 8 - 1 - __builtin_clzll(__n); }
  inline constexpr unsigned long long
  __lg(unsigned long long __n)
  { return sizeof(long long) * 8 - 1 - __builtin_clzll(__n); }

  template<typename _II1, typename _II2>
    inline bool
    equal(_II1 __first1, _II1 __last1, _II2 __first2)
    {
     
     
     
      ;
      return std::__equal_aux(std::__niter_base(__first1),
         std::__niter_base(__last1),
         std::__niter_base(__first2));
    }
  template<typename _IIter1, typename _IIter2, typename _BinaryPredicate>
    inline bool
    equal(_IIter1 __first1, _IIter1 __last1,
   _IIter2 __first2, _BinaryPredicate __binary_pred)
    {
     
     
      ;
      for (; __first1 != __last1; ++__first1, (void)++__first2)
 if (!bool(__binary_pred(*__first1, *__first2)))
   return false;
      return true;
    }
  template<typename _II1, typename _II2>
    inline bool
    __equal4(_II1 __first1, _II1 __last1, _II2 __first2, _II2 __last2)
    {
      using _RATag = random_access_iterator_tag;
      using _Cat1 = typename iterator_traits<_II1>::iterator_category;
      using _Cat2 = typename iterator_traits<_II2>::iterator_category;
      using _RAIters = __and_<is_same<_Cat1, _RATag>, is_same<_Cat2, _RATag>>;
      if (_RAIters())
 {
   auto __d1 = std::distance(__first1, __last1);
   auto __d2 = std::distance(__first2, __last2);
   if (__d1 != __d2)
     return false;
   return std::equal(__first1, __last1, __first2);
 }
      for (; __first1 != __last1 && __first2 != __last2;
   ++__first1, (void)++__first2)
 if (!(*__first1 == *__first2))
   return false;
      return __first1 == __last1 && __first2 == __last2;
    }
  template<typename _II1, typename _II2, typename _BinaryPredicate>
    inline bool
    __equal4(_II1 __first1, _II1 __last1, _II2 __first2, _II2 __last2,
      _BinaryPredicate __binary_pred)
    {
      using _RATag = random_access_iterator_tag;
      using _Cat1 = typename iterator_traits<_II1>::iterator_category;
      using _Cat2 = typename iterator_traits<_II2>::iterator_category;
      using _RAIters = __and_<is_same<_Cat1, _RATag>, is_same<_Cat2, _RATag>>;
      if (_RAIters())
 {
   auto __d1 = std::distance(__first1, __last1);
   auto __d2 = std::distance(__first2, __last2);
   if (__d1 != __d2)
     return false;
   return std::equal(__first1, __last1, __first2,
           __binary_pred);
 }
      for (; __first1 != __last1 && __first2 != __last2;
   ++__first1, (void)++__first2)
 if (!bool(__binary_pred(*__first1, *__first2)))
   return false;
      return __first1 == __last1 && __first2 == __last2;
    }
  template<typename _II1, typename _II2>
    inline bool
    equal(_II1 __first1, _II1 __last1, _II2 __first2, _II2 __last2)
    {
     
     
     
      ;
      ;
      return std::__equal4(__first1, __last1, __first2, __last2);
    }
  template<typename _IIter1, typename _IIter2, typename _BinaryPredicate>
    inline bool
    equal(_IIter1 __first1, _IIter1 __last1,
   _IIter2 __first2, _IIter2 __last2, _BinaryPredicate __binary_pred)
    {
     
     
      ;
      ;
      return std::__equal4(__first1, __last1, __first2, __last2,
          __binary_pred);
    }
  template<typename _II1, typename _II2>
    inline bool
    lexicographical_compare(_II1 __first1, _II1 __last1,
       _II2 __first2, _II2 __last2)
    {
     
     
     
     
      ;
      ;
      return std::__lexicographical_compare_aux(std::__niter_base(__first1),
      std::__niter_base(__last1),
      std::__niter_base(__first2),
      std::__niter_base(__last2));
    }
  template<typename _II1, typename _II2, typename _Compare>
    inline bool
    lexicographical_compare(_II1 __first1, _II1 __last1,
       _II2 __first2, _II2 __last2, _Compare __comp)
    {
     
     
      ;
      ;
      return std::__lexicographical_compare_impl
 (__first1, __last1, __first2, __last2,
  __gnu_cxx::__ops::__iter_comp_iter(__comp));
    }
  template<typename _InputIterator1, typename _InputIterator2,
    typename _BinaryPredicate>
    pair<_InputIterator1, _InputIterator2>
    __mismatch(_InputIterator1 __first1, _InputIterator1 __last1,
        _InputIterator2 __first2, _BinaryPredicate __binary_pred)
    {
      while (__first1 != __last1 && __binary_pred(__first1, __first2))
 {
   ++__first1;
   ++__first2;
 }
      return pair<_InputIterator1, _InputIterator2>(__first1, __first2);
    }
  template<typename _InputIterator1, typename _InputIterator2>
    inline pair<_InputIterator1, _InputIterator2>
    mismatch(_InputIterator1 __first1, _InputIterator1 __last1,
      _InputIterator2 __first2)
    {
     
     
     
      ;
      return std::__mismatch(__first1, __last1, __first2,
        __gnu_cxx::__ops::__iter_equal_to_iter());
    }
  template<typename _InputIterator1, typename _InputIterator2,
    typename _BinaryPredicate>
    inline pair<_InputIterator1, _InputIterator2>
    mismatch(_InputIterator1 __first1, _InputIterator1 __last1,
      _InputIterator2 __first2, _BinaryPredicate __binary_pred)
    {
     
     
      ;
      return std::__mismatch(__first1, __last1, __first2,
 __gnu_cxx::__ops::__iter_comp_iter(__binary_pred));
    }
  template<typename _InputIterator1, typename _InputIterator2,
    typename _BinaryPredicate>
    pair<_InputIterator1, _InputIterator2>
    __mismatch(_InputIterator1 __first1, _InputIterator1 __last1,
        _InputIterator2 __first2, _InputIterator2 __last2,
        _BinaryPredicate __binary_pred)
    {
      while (__first1 != __last1 && __first2 != __last2
      && __binary_pred(__first1, __first2))
 {
   ++__first1;
   ++__first2;
 }
      return pair<_InputIterator1, _InputIterator2>(__first1, __first2);
    }
  template<typename _InputIterator1, typename _InputIterator2>
    inline pair<_InputIterator1, _InputIterator2>
    mismatch(_InputIterator1 __first1, _InputIterator1 __last1,
      _InputIterator2 __first2, _InputIterator2 __last2)
    {
     
     
     
      ;
      ;
      return std::__mismatch(__first1, __last1, __first2, __last2,
        __gnu_cxx::__ops::__iter_equal_to_iter());
    }
  template<typename _InputIterator1, typename _InputIterator2,
    typename _BinaryPredicate>
    inline pair<_InputIterator1, _InputIterator2>
    mismatch(_InputIterator1 __first1, _InputIterator1 __last1,
      _InputIterator2 __first2, _InputIterator2 __last2,
      _BinaryPredicate __binary_pred)
    {
     
     
      ;
      ;
      return std::__mismatch(__first1, __last1, __first2, __last2,
        __gnu_cxx::__ops::__iter_comp_iter(__binary_pred));
    }


}
       
       
#pragma GCC visibility push(default)
       
#pragma GCC visibility push(default)
extern "C++" {
namespace std
{
  class exception
  {
  public:
    exception() noexcept { }
    virtual ~exception() noexcept;
    virtual const char*
    what() const noexcept;
  };
}
}
#pragma GCC visibility pop
extern "C++" {
namespace std
{
  class bad_exception : public exception
  {
  public:
    bad_exception() noexcept { }
    virtual ~bad_exception() noexcept;
    virtual const char*
    what() const noexcept;
  };
  typedef void (*terminate_handler) ();
  typedef void (*unexpected_handler) ();
  terminate_handler set_terminate(terminate_handler) noexcept;
  terminate_handler get_terminate() noexcept;
  void terminate() noexcept __attribute__ ((__noreturn__));
  unexpected_handler set_unexpected(unexpected_handler) noexcept;
  unexpected_handler get_unexpected() noexcept;
  void unexpected() __attribute__ ((__noreturn__));
 
  bool uncaught_exception() noexcept __attribute__ ((__pure__));
  int uncaught_exceptions() noexcept __attribute__ ((__pure__));
}
namespace __gnu_cxx
{

  void __verbose_terminate_handler();

}
}
#pragma GCC visibility pop
#pragma GCC visibility push(default)
       
#pragma GCC visibility push(default)
             
             
extern "C++" {
template <bool __test, typename __dsttype>
  struct __if_array;
template <typename __dsttype>
  struct __if_array <true, __dsttype> {
    typedef __dsttype __type;
};
}
#pragma pack(push,_CRT_PACKING)
extern "C" {
  typedef __builtin_va_list __gnuc_va_list;
  typedef __gnuc_va_list va_list;
}
#pragma pack(pop)
extern "C" {
void __attribute__((__cdecl__)) __debugbreak(void);
extern __inline__ __attribute__((__always_inline__,__gnu_inline__)) void __attribute__((__cdecl__)) __debugbreak(void)
{
  __asm__ __volatile__("int {$}3":);
}
const char *__mingw_get_crt_info (void);
}
#pragma pack(push,_CRT_PACKING)
__extension__ typedef unsigned long long size_t;
__extension__ typedef long long ssize_t;
typedef size_t rsize_t;
__extension__ typedef long long intptr_t;
__extension__ typedef unsigned long long uintptr_t;
__extension__ typedef long long ptrdiff_t;
typedef unsigned short wint_t;
typedef unsigned short wctype_t;
typedef int errno_t;
typedef long __time32_t;
__extension__ typedef long long __time64_t;
typedef __time64_t time_t;
struct threadlocaleinfostruct;
struct threadmbcinfostruct;
typedef struct threadlocaleinfostruct *pthreadlocinfo;
typedef struct threadmbcinfostruct *pthreadmbcinfo;
struct __lc_time_data;
typedef struct localeinfo_struct {
  pthreadlocinfo locinfo;
  pthreadmbcinfo mbcinfo;
} _locale_tstruct,*_locale_t;
typedef struct tagLC_ID {
  unsigned short wLanguage;
  unsigned short wCountry;
  unsigned short wCodePage;
} LC_ID,*LPLC_ID;
typedef struct threadlocaleinfostruct {
  int refcount;
  unsigned int lc_codepage;
  unsigned int lc_collate_cp;
  unsigned long lc_handle[6];
  LC_ID lc_id[6];
  struct {
    char *locale;
    wchar_t *wlocale;
    int *refcount;
    int *wrefcount;
  } lc_category[6];
  int lc_clike;
  int mb_cur_max;
  int *lconv_intl_refcount;
  int *lconv_num_refcount;
  int *lconv_mon_refcount;
  struct lconv *lconv;
  int *ctype1_refcount;
  unsigned short *ctype1;
  const unsigned short *pctype;
  const unsigned char *pclmap;
  const unsigned char *pcumap;
  struct __lc_time_data *lc_time_curr;
} threadlocinfo;
#pragma pack(pop)
extern "C" {
  __attribute__ ((__dllimport__)) extern int *__attribute__((__cdecl__)) _errno(void);
  errno_t __attribute__((__cdecl__)) _set_errno(int _Value);
  errno_t __attribute__((__cdecl__)) _get_errno(int *_Value);
  __attribute__ ((__dllimport__)) extern unsigned long __attribute__((__cdecl__)) __threadid(void);
  __attribute__ ((__dllimport__)) extern uintptr_t __attribute__((__cdecl__)) __threadhandle(void);
}
typedef struct {
  long long __max_align_ll __attribute__((__aligned__(__alignof__(long long))));
  long double __max_align_ld __attribute__((__aligned__(__alignof__(long double))));
} max_align_t;
namespace std
{
  class type_info;
}
namespace __cxxabiv1
{
  struct __cxa_refcounted_exception;
  extern "C"
    {
      void*
      __cxa_allocate_exception(size_t) noexcept;
      __cxa_refcounted_exception*
      __cxa_init_primary_exception(void *object, std::type_info *tinfo,
                void ( *dest) (void *)) noexcept;
    }
}
#pragma GCC visibility pop
       
       
namespace std
{

  size_t
  _Hash_bytes(const void* __ptr, size_t __len, size_t __seed);
  size_t
  _Fnv_hash_bytes(const void* __ptr, size_t __len, size_t __seed);

}
#pragma GCC visibility push(default)
extern "C++" {
namespace __cxxabiv1
{
  class __class_type_info;
}
namespace std
{
  class type_info
  {
  public:
    virtual ~type_info();
    const char* name() const noexcept
    { return __name[0] == '*' ? __name + 1 : __name; }
    bool before(const type_info& __arg) const noexcept;
    bool operator==(const type_info& __arg) const noexcept;
    bool operator!=(const type_info& __arg) const noexcept
    { return !operator==(__arg); }
    size_t hash_code() const noexcept
    {
      return _Hash_bytes(name(), __builtin_strlen(name()),
    static_cast<size_t>(0xc70f6907UL));
    }
    virtual bool __is_pointer_p() const;
    virtual bool __is_function_p() const;
    virtual bool __do_catch(const type_info *__thr_type, void **__thr_obj,
       unsigned __outer) const;
    virtual bool __do_upcast(const __cxxabiv1::__class_type_info *__target,
        void **__obj_ptr) const;
  protected:
    const char *__name;
    explicit type_info(const char *__n): __name(__n) { }
  private:
    type_info& operator=(const type_info&);
    type_info(const type_info&);
  };
  class bad_cast : public exception
  {
  public:
    bad_cast() noexcept { }
    virtual ~bad_cast() noexcept;
    virtual const char* what() const noexcept;
  };
  class bad_typeid : public exception
  {
  public:
    bad_typeid () noexcept { }
    virtual ~bad_typeid() noexcept;
    virtual const char* what() const noexcept;
  };
}
}
#pragma GCC visibility pop
extern "C++" {
namespace std
{
  class type_info;
  namespace __exception_ptr
  {
    class exception_ptr;
  }
  using __exception_ptr::exception_ptr;
  exception_ptr current_exception() noexcept;
  template<typename _Ex>
  exception_ptr make_exception_ptr(_Ex) noexcept;
  void rethrow_exception(exception_ptr) __attribute__ ((__noreturn__));
  namespace __exception_ptr
  {
    using std::rethrow_exception;
    class exception_ptr
    {
      void* _M_exception_object;
      explicit exception_ptr(void* __e) noexcept;
      void _M_addref() noexcept;
      void _M_release() noexcept;
      void *_M_get() const noexcept __attribute__ ((__pure__));
      friend exception_ptr std::current_exception() noexcept;
      friend void std::rethrow_exception(exception_ptr);
      template<typename _Ex>
      friend exception_ptr std::make_exception_ptr(_Ex) noexcept;
    public:
      exception_ptr() noexcept;
      exception_ptr(const exception_ptr&) noexcept;
      exception_ptr(nullptr_t) noexcept
      : _M_exception_object(0)
      { }
      exception_ptr(exception_ptr&& __o) noexcept
      : _M_exception_object(__o._M_exception_object)
      { __o._M_exception_object = 0; }
      exception_ptr&
      operator=(const exception_ptr&) noexcept;
      exception_ptr&
      operator=(exception_ptr&& __o) noexcept
      {
        exception_ptr(static_cast<exception_ptr&&>(__o)).swap(*this);
        return *this;
      }
      ~exception_ptr() noexcept;
      void
      swap(exception_ptr&) noexcept;
      explicit operator bool() const
      { return _M_exception_object; }
      friend bool
      operator==(const exception_ptr&, const exception_ptr&)
 noexcept __attribute__ ((__pure__));
      const class std::type_info*
      __cxa_exception_type() const noexcept
 __attribute__ ((__pure__));
    };
    bool
    operator==(const exception_ptr&, const exception_ptr&)
      noexcept __attribute__ ((__pure__));
    bool
    operator!=(const exception_ptr&, const exception_ptr&)
      noexcept __attribute__ ((__pure__));
    inline void
    swap(exception_ptr& __lhs, exception_ptr& __rhs)
    { __lhs.swap(__rhs); }
    template<typename _Ex>
      inline void
      __dest_thunk(void* __x)
      { static_cast<_Ex*>(__x)->~_Ex(); }
  }
  template<typename _Ex>
    exception_ptr
    make_exception_ptr(_Ex __ex) noexcept
    {
      try
 {
          void *__e = __cxxabiv1::__cxa_allocate_exception(sizeof(_Ex));
          (void)__cxxabiv1::__cxa_init_primary_exception(
       __e, const_cast<std::type_info*>(&typeid(__ex)),
       __exception_ptr::__dest_thunk<_Ex>);
          ::new (__e) _Ex(__ex);
          return exception_ptr(__e);
 }
      catch(...)
 {
   return current_exception();
 }
    }
}
}
#pragma GCC visibility pop
#pragma GCC visibility push(default)
extern "C++" {
namespace std
{
  class nested_exception
  {
    exception_ptr _M_ptr;
  public:
    nested_exception() noexcept : _M_ptr(current_exception()) { }
    nested_exception(const nested_exception&) noexcept = default;
    nested_exception& operator=(const nested_exception&) noexcept = default;
    virtual ~nested_exception() noexcept;
    [[noreturn]]
    void
    rethrow_nested() const
    {
      if (_M_ptr)
 rethrow_exception(_M_ptr);
      std::terminate();
    }
    exception_ptr
    nested_ptr() const noexcept
    { return _M_ptr; }
  };
  template<typename _Except>
    struct _Nested_exception : public _Except, public nested_exception
    {
      explicit _Nested_exception(const _Except& __ex)
      : _Except(__ex)
      { }
      explicit _Nested_exception(_Except&& __ex)
      : _Except(static_cast<_Except&&>(__ex))
      { }
    };
  template<typename _Tp>
    [[noreturn]]
    inline void
    __throw_with_nested_impl(_Tp&& __t, true_type)
    {
      using _Up = typename remove_reference<_Tp>::type;
      throw _Nested_exception<_Up>{std::forward<_Tp>(__t)};
    }
  template<typename _Tp>
    [[noreturn]]
    inline void
    __throw_with_nested_impl(_Tp&& __t, false_type)
    { throw std::forward<_Tp>(__t); }
  template<typename _Tp>
    [[noreturn]]
    inline void
    throw_with_nested(_Tp&& __t)
    {
      using _Up = typename decay<_Tp>::type;
      using _CopyConstructible
 = __and_<is_copy_constructible<_Up>, is_move_constructible<_Up>>;
      static_assert(_CopyConstructible::value,
   "throw_with_nested argument must be CopyConstructible");
      using __nest = __and_<is_class<_Up>, __bool_constant<!__is_final(_Up)>,
       __not_<is_base_of<nested_exception, _Up>>>;
      std::__throw_with_nested_impl(std::forward<_Tp>(__t), __nest{});
    }
  template<typename _Tp>
    using __rethrow_if_nested_cond = typename enable_if<
      __and_<is_polymorphic<_Tp>,
      __or_<__not_<is_base_of<nested_exception, _Tp>>,
     is_convertible<_Tp*, nested_exception*>>>::value
    >::type;
  template<typename _Ex>
    inline __rethrow_if_nested_cond<_Ex>
    __rethrow_if_nested_impl(const _Ex* __ptr)
    {
      if (auto __ne_ptr = dynamic_cast<const nested_exception*>(__ptr))
 __ne_ptr->rethrow_nested();
    }
  inline void
  __rethrow_if_nested_impl(const void*)
  { }
  template<typename _Ex>
    inline void
    rethrow_if_nested(const _Ex& __ex)
    { std::__rethrow_if_nested_impl(std::__addressof(__ex)); }
}
}
#pragma GCC visibility pop
#pragma GCC visibility push(default)
extern "C++" {
namespace std
{
  class bad_alloc : public exception
  {
  public:
    bad_alloc() throw() { }
    virtual ~bad_alloc() throw();
    virtual const char* what() const throw();
  };
  class bad_array_new_length : public bad_alloc
  {
  public:
    bad_array_new_length() throw() { }
    virtual ~bad_array_new_length() throw();
    virtual const char* what() const throw();
  };
  struct nothrow_t
  {
    explicit nothrow_t() = default;
  };
  extern const nothrow_t nothrow;
  typedef void (*new_handler)();
  new_handler set_new_handler(new_handler) throw();
  new_handler get_new_handler() noexcept;
}
void* operator new(std::size_t)
  __attribute__((__externally_visible__));
void* operator new[](std::size_t)
  __attribute__((__externally_visible__));
void operator delete(void*) noexcept
  __attribute__((__externally_visible__));
void operator delete[](void*) noexcept
  __attribute__((__externally_visible__));
void operator delete(void*, std::size_t) noexcept
  __attribute__((__externally_visible__));
void operator delete[](void*, std::size_t) noexcept
  __attribute__((__externally_visible__));
void* operator new(std::size_t, const std::nothrow_t&) noexcept
  __attribute__((__externally_visible__));
void* operator new[](std::size_t, const std::nothrow_t&) noexcept
  __attribute__((__externally_visible__));
void operator delete(void*, const std::nothrow_t&) noexcept
  __attribute__((__externally_visible__));
void operator delete[](void*, const std::nothrow_t&) noexcept
  __attribute__((__externally_visible__));
inline void* operator new(std::size_t, void* __p) noexcept
{ return __p; }
inline void* operator new[](std::size_t, void* __p) noexcept
{ return __p; }
inline void operator delete (void*, void*) noexcept { }
inline void operator delete[](void*, void*) noexcept { }
}
#pragma GCC visibility pop
namespace __gnu_cxx
{

  using std::size_t;
  using std::ptrdiff_t;
  template<typename _Tp>
    class new_allocator
    {
    public:
      typedef size_t size_type;
      typedef ptrdiff_t difference_type;
      typedef _Tp* pointer;
      typedef const _Tp* const_pointer;
      typedef _Tp& reference;
      typedef const _Tp& const_reference;
      typedef _Tp value_type;
      template<typename _Tp1>
 struct rebind
 { typedef new_allocator<_Tp1> other; };
      typedef std::true_type propagate_on_container_move_assignment;
      new_allocator() noexcept { }
      new_allocator(const new_allocator&) noexcept { }
      template<typename _Tp1>
 new_allocator(const new_allocator<_Tp1>&) noexcept { }
      ~new_allocator() noexcept { }
      pointer
      address(reference __x) const noexcept
      { return std::__addressof(__x); }
      const_pointer
      address(const_reference __x) const noexcept
      { return std::__addressof(__x); }
      pointer
      allocate(size_type __n, const void* = static_cast<const void*>(0))
      {
 if (__n > this->max_size())
   std::__throw_bad_alloc();
 return static_cast<_Tp*>(::operator new(__n * sizeof(_Tp)));
      }
      void
      deallocate(pointer __p, size_type)
      {
 ::operator delete(__p);
      }
      size_type
      max_size() const noexcept
      { return size_t(-1) / sizeof(_Tp); }
      template<typename _Up, typename... _Args>
 void
 construct(_Up* __p, _Args&&... __args)
 { ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
      template<typename _Up>
 void
 destroy(_Up* __p) { __p->~_Up(); }
    };
  template<typename _Tp>
    inline bool
    operator==(const new_allocator<_Tp>&, const new_allocator<_Tp>&)
    { return true; }
  template<typename _Tp>
    inline bool
    operator!=(const new_allocator<_Tp>&, const new_allocator<_Tp>&)
    { return false; }

}
namespace std
{
  template<typename _Tp>
    using __allocator_base = __gnu_cxx::new_allocator<_Tp>;
}
       
namespace std
{

  template<typename>
    class allocator;
  template<>
    class allocator<void>;
  template<typename, typename>
    struct uses_allocator;

}
namespace std
{

  template<>
    class allocator<void>
    {
    public:
      typedef size_t size_type;
      typedef ptrdiff_t difference_type;
      typedef void* pointer;
      typedef const void* const_pointer;
      typedef void value_type;
      template<typename _Tp1>
 struct rebind
 { typedef allocator<_Tp1> other; };
      typedef true_type propagate_on_container_move_assignment;
      typedef true_type is_always_equal;
      template<typename _Up, typename... _Args>
 void
 construct(_Up* __p, _Args&&... __args)
 { ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
      template<typename _Up>
 void
 destroy(_Up* __p) { __p->~_Up(); }
    };
  template<typename _Tp>
    class allocator : public __allocator_base<_Tp>
    {
   public:
      typedef size_t size_type;
      typedef ptrdiff_t difference_type;
      typedef _Tp* pointer;
      typedef const _Tp* const_pointer;
      typedef _Tp& reference;
      typedef const _Tp& const_reference;
      typedef _Tp value_type;
      template<typename _Tp1>
 struct rebind
 { typedef allocator<_Tp1> other; };
      typedef true_type propagate_on_container_move_assignment;
      typedef true_type is_always_equal;
      allocator() throw() { }
      allocator(const allocator& __a) throw()
      : __allocator_base<_Tp>(__a) { }
      template<typename _Tp1>
 allocator(const allocator<_Tp1>&) throw() { }
      ~allocator() throw() { }
    };
  template<typename _T1, typename _T2>
    inline bool
    operator==(const allocator<_T1>&, const allocator<_T2>&)
    noexcept
    { return true; }
  template<typename _Tp>
    inline bool
    operator==(const allocator<_Tp>&, const allocator<_Tp>&)
    noexcept
    { return true; }
  template<typename _T1, typename _T2>
    inline bool
    operator!=(const allocator<_T1>&, const allocator<_T2>&)
    noexcept
    { return false; }
  template<typename _Tp>
    inline bool
    operator!=(const allocator<_Tp>&, const allocator<_Tp>&)
    noexcept
    { return false; }
  template<typename _Tp>
    class allocator<const _Tp>
    {
    public:
      typedef _Tp value_type;
      template<typename _Up> allocator(const allocator<_Up>&) { }
    };
  template<typename _Tp>
    class allocator<volatile _Tp>
    {
    public:
      typedef _Tp value_type;
      template<typename _Up> allocator(const allocator<_Up>&) { }
    };
  template<typename _Tp>
    class allocator<const volatile _Tp>
    {
    public:
      typedef _Tp value_type;
      template<typename _Up> allocator(const allocator<_Up>&) { }
    };
  extern template class allocator<char>;
  extern template class allocator<wchar_t>;
  template<typename _Alloc, bool = __is_empty(_Alloc)>
    struct __alloc_swap
    { static void _S_do_it(_Alloc&, _Alloc&) noexcept { } };
  template<typename _Alloc>
    struct __alloc_swap<_Alloc, false>
    {
      static void
      _S_do_it(_Alloc& __one, _Alloc& __two) noexcept
      {
 if (__one != __two)
   swap(__one, __two);
      }
    };
  template<typename _Alloc, bool = __is_empty(_Alloc)>
    struct __alloc_neq
    {
      static bool
      _S_do_it(const _Alloc&, const _Alloc&)
      { return false; }
    };
  template<typename _Alloc>
    struct __alloc_neq<_Alloc, false>
    {
      static bool
      _S_do_it(const _Alloc& __one, const _Alloc& __two)
      { return __one != __two; }
    };
  template<typename _Tp, bool
    = __or_<is_copy_constructible<typename _Tp::value_type>,
            is_nothrow_move_constructible<typename _Tp::value_type>>::value>
    struct __shrink_to_fit_aux
    { static bool _S_do_it(_Tp&) noexcept { return false; } };
  template<typename _Tp>
    struct __shrink_to_fit_aux<_Tp, true>
    {
      static bool
      _S_do_it(_Tp& __c) noexcept
      {
 try
   {
     _Tp(__make_move_if_noexcept_iterator(__c.begin()),
  __make_move_if_noexcept_iterator(__c.end()),
  __c.get_allocator()).swap(__c);
     return true;
   }
 catch(...)
   { return false; }
      }
    };

}
       
namespace std
{

  struct __allocator_traits_base
  {
    template<typename _Tp, typename _Up, typename = void>
      struct __rebind : __replace_first_arg<_Tp, _Up> { };
    template<typename _Tp, typename _Up>
      struct __rebind<_Tp, _Up,
        __void_t<typename _Tp::template rebind<_Up>::other>>
      { using type = typename _Tp::template rebind<_Up>::other; };
  protected:
    template<typename _Tp>
      using __pointer = typename _Tp::pointer;
    template<typename _Tp>
      using __c_pointer = typename _Tp::const_pointer;
    template<typename _Tp>
      using __v_pointer = typename _Tp::void_pointer;
    template<typename _Tp>
      using __cv_pointer = typename _Tp::const_void_pointer;
    template<typename _Tp>
      using __pocca = typename _Tp::propagate_on_container_copy_assignment;
    template<typename _Tp>
      using __pocma = typename _Tp::propagate_on_container_move_assignment;
    template<typename _Tp>
      using __pocs = typename _Tp::propagate_on_container_swap;
    template<typename _Tp>
      using __equal = typename _Tp::is_always_equal;
  };
  template<typename _Alloc, typename _Up>
    using __alloc_rebind
      = typename __allocator_traits_base::template __rebind<_Alloc, _Up>::type;
  template<typename _Alloc>
    struct allocator_traits : __allocator_traits_base
    {
      typedef _Alloc allocator_type;
      typedef typename _Alloc::value_type value_type;
      using pointer = __detected_or_t<value_type*, __pointer, _Alloc>;
    private:
      template<template<typename> class _Func, typename _Tp, typename = void>
 struct _Ptr
 {
   using type = typename pointer_traits<pointer>::template rebind<_Tp>;
 };
      template<template<typename> class _Func, typename _Tp>
 struct _Ptr<_Func, _Tp, __void_t<_Func<_Alloc>>>
 {
   using type = _Func<_Alloc>;
 };
      template<typename _A2, typename _PtrT, typename = void>
 struct _Diff
 { using type = typename pointer_traits<_PtrT>::difference_type; };
      template<typename _A2, typename _PtrT>
 struct _Diff<_A2, _PtrT, __void_t<typename _A2::difference_type>>
 { using type = typename _A2::difference_type; };
      template<typename _A2, typename _DiffT, typename = void>
 struct _Size : make_unsigned<_DiffT> { };
      template<typename _A2, typename _DiffT>
 struct _Size<_A2, _DiffT, __void_t<typename _A2::size_type>>
 { using type = typename _A2::size_type; };
    public:
      using const_pointer = typename _Ptr<__c_pointer, const value_type>::type;
      using void_pointer = typename _Ptr<__v_pointer, void>::type;
      using const_void_pointer = typename _Ptr<__cv_pointer, const void>::type;
      using difference_type = typename _Diff<_Alloc, pointer>::type;
      using size_type = typename _Size<_Alloc, difference_type>::type;
      using propagate_on_container_copy_assignment
 = __detected_or_t<false_type, __pocca, _Alloc>;
      using propagate_on_container_move_assignment
 = __detected_or_t<false_type, __pocma, _Alloc>;
      using propagate_on_container_swap
 = __detected_or_t<false_type, __pocs, _Alloc>;
      using is_always_equal
 = __detected_or_t<typename is_empty<_Alloc>::type, __equal, _Alloc>;
      template<typename _Tp>
 using rebind_alloc = __alloc_rebind<_Alloc, _Tp>;
      template<typename _Tp>
 using rebind_traits = allocator_traits<rebind_alloc<_Tp>>;
    private:
      template<typename _Alloc2>
 static auto
 _S_allocate(_Alloc2& __a, size_type __n, const_void_pointer __hint, int)
 -> decltype(__a.allocate(__n, __hint))
 { return __a.allocate(__n, __hint); }
      template<typename _Alloc2>
 static pointer
 _S_allocate(_Alloc2& __a, size_type __n, const_void_pointer, ...)
 { return __a.allocate(__n); }
      template<typename _Tp, typename... _Args>
 struct __construct_helper
 {
   template<typename _Alloc2,
     typename = decltype(std::declval<_Alloc2*>()->construct(
    std::declval<_Tp*>(), std::declval<_Args>()...))>
     static true_type __test(int);
   template<typename>
     static false_type __test(...);
   using type = decltype(__test<_Alloc>(0));
 };
      template<typename _Tp, typename... _Args>
 using __has_construct
   = typename __construct_helper<_Tp, _Args...>::type;
      template<typename _Tp, typename... _Args>
 static _Require<__has_construct<_Tp, _Args...>>
 _S_construct(_Alloc& __a, _Tp* __p, _Args&&... __args)
 { __a.construct(__p, std::forward<_Args>(__args)...); }
      template<typename _Tp, typename... _Args>
 static
 _Require<__and_<__not_<__has_construct<_Tp, _Args...>>,
          is_constructible<_Tp, _Args...>>>
 _S_construct(_Alloc&, _Tp* __p, _Args&&... __args)
 { ::new((void*)__p) _Tp(std::forward<_Args>(__args)...); }
      template<typename _Alloc2, typename _Tp>
 static auto
 _S_destroy(_Alloc2& __a, _Tp* __p, int)
 -> decltype(__a.destroy(__p))
 { __a.destroy(__p); }
      template<typename _Alloc2, typename _Tp>
 static void
 _S_destroy(_Alloc2&, _Tp* __p, ...)
 { __p->~_Tp(); }
      template<typename _Alloc2>
 static auto
 _S_max_size(_Alloc2& __a, int)
 -> decltype(__a.max_size())
 { return __a.max_size(); }
      template<typename _Alloc2>
 static size_type
 _S_max_size(_Alloc2&, ...)
 {
   return __gnu_cxx::__numeric_traits<size_type>::__max
     / sizeof(value_type);
 }
      template<typename _Alloc2>
 static auto
 _S_select(_Alloc2& __a, int)
 -> decltype(__a.select_on_container_copy_construction())
 { return __a.select_on_container_copy_construction(); }
      template<typename _Alloc2>
 static _Alloc2
 _S_select(_Alloc2& __a, ...)
 { return __a; }
    public:
      static pointer
      allocate(_Alloc& __a, size_type __n)
      { return __a.allocate(__n); }
      static pointer
      allocate(_Alloc& __a, size_type __n, const_void_pointer __hint)
      { return _S_allocate(__a, __n, __hint, 0); }
      static void
      deallocate(_Alloc& __a, pointer __p, size_type __n)
      { __a.deallocate(__p, __n); }
      template<typename _Tp, typename... _Args>
 static auto construct(_Alloc& __a, _Tp* __p, _Args&&... __args)
 -> decltype(_S_construct(__a, __p, std::forward<_Args>(__args)...))
 { _S_construct(__a, __p, std::forward<_Args>(__args)...); }
      template<typename _Tp>
 static void destroy(_Alloc& __a, _Tp* __p)
 { _S_destroy(__a, __p, 0); }
      static size_type max_size(const _Alloc& __a) noexcept
      { return _S_max_size(__a, 0); }
      static _Alloc
      select_on_container_copy_construction(const _Alloc& __rhs)
      { return _S_select(__rhs, 0); }
    };
  template<typename _Tp>
    struct allocator_traits<allocator<_Tp>>
    {
      using allocator_type = allocator<_Tp>;
      using value_type = _Tp;
      using pointer = _Tp*;
      using const_pointer = const _Tp*;
      using void_pointer = void*;
      using const_void_pointer = const void*;
      using difference_type = std::ptrdiff_t;
      using size_type = std::size_t;
      using propagate_on_container_copy_assignment = false_type;
      using propagate_on_container_move_assignment = true_type;
      using propagate_on_container_swap = false_type;
      using is_always_equal = true_type;
      template<typename _Up>
 using rebind_alloc = allocator<_Up>;
      template<typename _Up>
 using rebind_traits = allocator_traits<allocator<_Up>>;
      static pointer
      allocate(allocator_type& __a, size_type __n)
      { return __a.allocate(__n); }
      static pointer
      allocate(allocator_type& __a, size_type __n, const_void_pointer __hint)
      { return __a.allocate(__n, __hint); }
      static void
      deallocate(allocator_type& __a, pointer __p, size_type __n)
      { __a.deallocate(__p, __n); }
      template<typename _Up, typename... _Args>
 static void
 construct(allocator_type& __a, _Up* __p, _Args&&... __args)
 { __a.construct(__p, std::forward<_Args>(__args)...); }
      template<typename _Up>
 static void
 destroy(allocator_type& __a, _Up* __p)
 { __a.destroy(__p); }
      static size_type
      max_size(const allocator_type& __a) noexcept
      { return __a.max_size(); }
      static allocator_type
      select_on_container_copy_construction(const allocator_type& __rhs)
      { return __rhs; }
    };
  template<typename _Alloc>
    inline void
    __do_alloc_on_copy(_Alloc& __one, const _Alloc& __two, true_type)
    { __one = __two; }
  template<typename _Alloc>
    inline void
    __do_alloc_on_copy(_Alloc&, const _Alloc&, false_type)
    { }
  template<typename _Alloc>
    inline void __alloc_on_copy(_Alloc& __one, const _Alloc& __two)
    {
      typedef allocator_traits<_Alloc> __traits;
      typedef typename __traits::propagate_on_container_copy_assignment __pocca;
      __do_alloc_on_copy(__one, __two, __pocca());
    }
  template<typename _Alloc>
    inline _Alloc __alloc_on_copy(const _Alloc& __a)
    {
      typedef allocator_traits<_Alloc> __traits;
      return __traits::select_on_container_copy_construction(__a);
    }
  template<typename _Alloc>
    inline void __do_alloc_on_move(_Alloc& __one, _Alloc& __two, true_type)
    { __one = std::move(__two); }
  template<typename _Alloc>
    inline void __do_alloc_on_move(_Alloc&, _Alloc&, false_type)
    { }
  template<typename _Alloc>
    inline void __alloc_on_move(_Alloc& __one, _Alloc& __two)
    {
      typedef allocator_traits<_Alloc> __traits;
      typedef typename __traits::propagate_on_container_move_assignment __pocma;
      __do_alloc_on_move(__one, __two, __pocma());
    }
  template<typename _Alloc>
    inline void __do_alloc_on_swap(_Alloc& __one, _Alloc& __two, true_type)
    {
      using std::swap;
      swap(__one, __two);
    }
  template<typename _Alloc>
    inline void __do_alloc_on_swap(_Alloc&, _Alloc&, false_type)
    { }
  template<typename _Alloc>
    inline void __alloc_on_swap(_Alloc& __one, _Alloc& __two)
    {
      typedef allocator_traits<_Alloc> __traits;
      typedef typename __traits::propagate_on_container_swap __pocs;
      __do_alloc_on_swap(__one, __two, __pocs());
    }
  template<typename _Alloc>
    class __is_copy_insertable_impl
    {
      typedef allocator_traits<_Alloc> _Traits;
      template<typename _Up, typename
        = decltype(_Traits::construct(std::declval<_Alloc&>(),
          std::declval<_Up*>(),
          std::declval<const _Up&>()))>
 static true_type
 _M_select(int);
      template<typename _Up>
 static false_type
 _M_select(...);
    public:
      typedef decltype(_M_select<typename _Alloc::value_type>(0)) type;
    };
  template<typename _Alloc>
    struct __is_copy_insertable
    : __is_copy_insertable_impl<_Alloc>::type
    { };
  template<typename _Tp>
    struct __is_copy_insertable<allocator<_Tp>>
    : is_copy_constructible<_Tp>
    { };
  template<typename _Alloc, typename = void>
    struct __is_allocator : false_type { };
  template<typename _Alloc>
    struct __is_allocator<_Alloc,
      __void_t<typename _Alloc::value_type,
        decltype(std::declval<_Alloc&>().allocate(size_t{}))>>
    : true_type { };
  template<typename _Alloc>
    using _RequireAllocator
      = typename enable_if<__is_allocator<_Alloc>::value, _Alloc>::type;

}
namespace __gnu_cxx
{

template<typename _Alloc, typename = typename _Alloc::value_type>
  struct __alloc_traits
  : std::allocator_traits<_Alloc>
  {
    typedef _Alloc allocator_type;
    typedef std::allocator_traits<_Alloc> _Base_type;
    typedef typename _Base_type::value_type value_type;
    typedef typename _Base_type::pointer pointer;
    typedef typename _Base_type::const_pointer const_pointer;
    typedef typename _Base_type::size_type size_type;
    typedef typename _Base_type::difference_type difference_type;
    typedef value_type& reference;
    typedef const value_type& const_reference;
    using _Base_type::allocate;
    using _Base_type::deallocate;
    using _Base_type::construct;
    using _Base_type::destroy;
    using _Base_type::max_size;
  private:
    template<typename _Ptr>
      using __is_custom_pointer
 = std::__and_<std::is_same<pointer, _Ptr>,
        std::__not_<std::is_pointer<_Ptr>>>;
  public:
    template<typename _Ptr, typename... _Args>
      static typename std::enable_if<__is_custom_pointer<_Ptr>::value>::type
      construct(_Alloc& __a, _Ptr __p, _Args&&... __args)
      {
 _Base_type::construct(__a, std::__to_address(__p),
         std::forward<_Args>(__args)...);
      }
    template<typename _Ptr>
      static typename std::enable_if<__is_custom_pointer<_Ptr>::value>::type
      destroy(_Alloc& __a, _Ptr __p)
      { _Base_type::destroy(__a, std::__to_address(__p)); }
    static _Alloc _S_select_on_copy(const _Alloc& __a)
    { return _Base_type::select_on_container_copy_construction(__a); }
    static void _S_on_swap(_Alloc& __a, _Alloc& __b)
    { std::__alloc_on_swap(__a, __b); }
    static constexpr bool _S_propagate_on_copy_assign()
    { return _Base_type::propagate_on_container_copy_assignment::value; }
    static constexpr bool _S_propagate_on_move_assign()
    { return _Base_type::propagate_on_container_move_assignment::value; }
    static constexpr bool _S_propagate_on_swap()
    { return _Base_type::propagate_on_container_swap::value; }
    static constexpr bool _S_always_equal()
    { return _Base_type::is_always_equal::value; }
    static constexpr bool _S_nothrow_move()
    { return _S_propagate_on_move_assign() || _S_always_equal(); }
    template<typename _Tp>
      struct rebind
      { typedef typename _Base_type::template rebind_alloc<_Tp> other; };
  };

}
namespace std
{

  template<typename _T1, typename... _Args>
    inline void
    _Construct(_T1* __p, _Args&&... __args)
    { ::new(static_cast<void*>(__p)) _T1(std::forward<_Args>(__args)...); }
  template<typename _T1>
    inline void
    _Construct_novalue(_T1* __p)
    { ::new(static_cast<void*>(__p)) _T1; }
  template<typename _Tp>
    inline void
    _Destroy(_Tp* __pointer)
    { __pointer->~_Tp(); }
  template<bool>
    struct _Destroy_aux
    {
      template<typename _ForwardIterator>
        static void
        __destroy(_ForwardIterator __first, _ForwardIterator __last)
 {
   for (; __first != __last; ++__first)
     std::_Destroy(std::__addressof(*__first));
 }
    };
  template<>
    struct _Destroy_aux<true>
    {
      template<typename _ForwardIterator>
        static void
        __destroy(_ForwardIterator, _ForwardIterator) { }
    };
  template<typename _ForwardIterator>
    inline void
    _Destroy(_ForwardIterator __first, _ForwardIterator __last)
    {
      typedef typename iterator_traits<_ForwardIterator>::value_type
                       _Value_type;
      static_assert(is_destructible<_Value_type>::value,
      "value type is destructible");
      std::_Destroy_aux<__has_trivial_destructor(_Value_type)>::
 __destroy(__first, __last);
    }
  template<bool>
    struct _Destroy_n_aux
    {
      template<typename _ForwardIterator, typename _Size>
        static _ForwardIterator
        __destroy_n(_ForwardIterator __first, _Size __count)
 {
   for (; __count > 0; (void)++__first, --__count)
     std::_Destroy(std::__addressof(*__first));
   return __first;
 }
    };
  template<>
    struct _Destroy_n_aux<true>
    {
      template<typename _ForwardIterator, typename _Size>
        static _ForwardIterator
        __destroy_n(_ForwardIterator __first, _Size __count)
 {
   std::advance(__first, __count);
   return __first;
 }
    };
  template<typename _ForwardIterator, typename _Size>
    inline _ForwardIterator
    _Destroy_n(_ForwardIterator __first, _Size __count)
    {
      typedef typename iterator_traits<_ForwardIterator>::value_type
                       _Value_type;
      static_assert(is_destructible<_Value_type>::value,
      "value type is destructible");
      return std::_Destroy_n_aux<__has_trivial_destructor(_Value_type)>::
 __destroy_n(__first, __count);
    }
  template<typename _ForwardIterator, typename _Allocator>
    void
    _Destroy(_ForwardIterator __first, _ForwardIterator __last,
      _Allocator& __alloc)
    {
      typedef __gnu_cxx::__alloc_traits<_Allocator> __traits;
      for (; __first != __last; ++__first)
 __traits::destroy(__alloc, std::__addressof(*__first));
    }
  template<typename _ForwardIterator, typename _Tp>
    inline void
    _Destroy(_ForwardIterator __first, _ForwardIterator __last,
      allocator<_Tp>&)
    {
      _Destroy(__first, __last);
    }

}
namespace std
{

  template<bool _TrivialValueTypes>
    struct __uninitialized_copy
    {
      template<typename _InputIterator, typename _ForwardIterator>
        static _ForwardIterator
        __uninit_copy(_InputIterator __first, _InputIterator __last,
        _ForwardIterator __result)
        {
   _ForwardIterator __cur = __result;
   try
     {
       for (; __first != __last; ++__first, (void)++__cur)
  std::_Construct(std::__addressof(*__cur), *__first);
       return __cur;
     }
   catch(...)
     {
       std::_Destroy(__result, __cur);
       throw;
     }
 }
    };
  template<>
    struct __uninitialized_copy<true>
    {
      template<typename _InputIterator, typename _ForwardIterator>
        static _ForwardIterator
        __uninit_copy(_InputIterator __first, _InputIterator __last,
        _ForwardIterator __result)
        { return std::copy(__first, __last, __result); }
    };
  template<typename _InputIterator, typename _ForwardIterator>
    inline _ForwardIterator
    uninitialized_copy(_InputIterator __first, _InputIterator __last,
         _ForwardIterator __result)
    {
      typedef typename iterator_traits<_InputIterator>::value_type
 _ValueType1;
      typedef typename iterator_traits<_ForwardIterator>::value_type
 _ValueType2;
      typedef typename iterator_traits<_InputIterator>::reference _RefType1;
      typedef typename iterator_traits<_ForwardIterator>::reference _RefType2;
      const bool __assignable = is_assignable<_RefType2, _RefType1>::value;
      return std::__uninitialized_copy<__is_trivial(_ValueType1)
           && __is_trivial(_ValueType2)
           && __assignable>::
 __uninit_copy(__first, __last, __result);
    }
  template<bool _TrivialValueType>
    struct __uninitialized_fill
    {
      template<typename _ForwardIterator, typename _Tp>
        static void
        __uninit_fill(_ForwardIterator __first, _ForwardIterator __last,
        const _Tp& __x)
        {
   _ForwardIterator __cur = __first;
   try
     {
       for (; __cur != __last; ++__cur)
  std::_Construct(std::__addressof(*__cur), __x);
     }
   catch(...)
     {
       std::_Destroy(__first, __cur);
       throw;
     }
 }
    };
  template<>
    struct __uninitialized_fill<true>
    {
      template<typename _ForwardIterator, typename _Tp>
        static void
        __uninit_fill(_ForwardIterator __first, _ForwardIterator __last,
        const _Tp& __x)
        { std::fill(__first, __last, __x); }
    };
  template<typename _ForwardIterator, typename _Tp>
    inline void
    uninitialized_fill(_ForwardIterator __first, _ForwardIterator __last,
         const _Tp& __x)
    {
      typedef typename iterator_traits<_ForwardIterator>::value_type
 _ValueType;
      const bool __assignable = is_copy_assignable<_ValueType>::value;
      std::__uninitialized_fill<__is_trivial(_ValueType) && __assignable>::
 __uninit_fill(__first, __last, __x);
    }
  template<bool _TrivialValueType>
    struct __uninitialized_fill_n
    {
      template<typename _ForwardIterator, typename _Size, typename _Tp>
        static _ForwardIterator
        __uninit_fill_n(_ForwardIterator __first, _Size __n,
   const _Tp& __x)
        {
   _ForwardIterator __cur = __first;
   try
     {
       for (; __n > 0; --__n, (void) ++__cur)
  std::_Construct(std::__addressof(*__cur), __x);
       return __cur;
     }
   catch(...)
     {
       std::_Destroy(__first, __cur);
       throw;
     }
 }
    };
  template<>
    struct __uninitialized_fill_n<true>
    {
      template<typename _ForwardIterator, typename _Size, typename _Tp>
        static _ForwardIterator
        __uninit_fill_n(_ForwardIterator __first, _Size __n,
   const _Tp& __x)
        { return std::fill_n(__first, __n, __x); }
    };
  template<typename _ForwardIterator, typename _Size, typename _Tp>
    inline _ForwardIterator
    uninitialized_fill_n(_ForwardIterator __first, _Size __n, const _Tp& __x)
    {
      typedef typename iterator_traits<_ForwardIterator>::value_type
 _ValueType;
      const bool __assignable = is_copy_assignable<_ValueType>::value;
      return __uninitialized_fill_n<__is_trivial(_ValueType) && __assignable>::
 __uninit_fill_n(__first, __n, __x);
    }
  template<typename _InputIterator, typename _ForwardIterator,
    typename _Allocator>
    _ForwardIterator
    __uninitialized_copy_a(_InputIterator __first, _InputIterator __last,
      _ForwardIterator __result, _Allocator& __alloc)
    {
      _ForwardIterator __cur = __result;
      try
 {
   typedef __gnu_cxx::__alloc_traits<_Allocator> __traits;
   for (; __first != __last; ++__first, (void)++__cur)
     __traits::construct(__alloc, std::__addressof(*__cur), *__first);
   return __cur;
 }
      catch(...)
 {
   std::_Destroy(__result, __cur, __alloc);
   throw;
 }
    }
  template<typename _InputIterator, typename _ForwardIterator, typename _Tp>
    inline _ForwardIterator
    __uninitialized_copy_a(_InputIterator __first, _InputIterator __last,
      _ForwardIterator __result, allocator<_Tp>&)
    { return std::uninitialized_copy(__first, __last, __result); }
  template<typename _InputIterator, typename _ForwardIterator,
    typename _Allocator>
    inline _ForwardIterator
    __uninitialized_move_a(_InputIterator __first, _InputIterator __last,
      _ForwardIterator __result, _Allocator& __alloc)
    {
      return std::__uninitialized_copy_a(std::make_move_iterator(__first),
      std::make_move_iterator(__last),
      __result, __alloc);
    }
  template<typename _InputIterator, typename _ForwardIterator,
    typename _Allocator>
    inline _ForwardIterator
    __uninitialized_move_if_noexcept_a(_InputIterator __first,
           _InputIterator __last,
           _ForwardIterator __result,
           _Allocator& __alloc)
    {
      return std::__uninitialized_copy_a
 (std::__make_move_if_noexcept_iterator(__first),
  std::__make_move_if_noexcept_iterator(__last), __result, __alloc);
    }
  template<typename _ForwardIterator, typename _Tp, typename _Allocator>
    void
    __uninitialized_fill_a(_ForwardIterator __first, _ForwardIterator __last,
      const _Tp& __x, _Allocator& __alloc)
    {
      _ForwardIterator __cur = __first;
      try
 {
   typedef __gnu_cxx::__alloc_traits<_Allocator> __traits;
   for (; __cur != __last; ++__cur)
     __traits::construct(__alloc, std::__addressof(*__cur), __x);
 }
      catch(...)
 {
   std::_Destroy(__first, __cur, __alloc);
   throw;
 }
    }
  template<typename _ForwardIterator, typename _Tp, typename _Tp2>
    inline void
    __uninitialized_fill_a(_ForwardIterator __first, _ForwardIterator __last,
      const _Tp& __x, allocator<_Tp2>&)
    { std::uninitialized_fill(__first, __last, __x); }
  template<typename _ForwardIterator, typename _Size, typename _Tp,
    typename _Allocator>
    _ForwardIterator
    __uninitialized_fill_n_a(_ForwardIterator __first, _Size __n,
        const _Tp& __x, _Allocator& __alloc)
    {
      _ForwardIterator __cur = __first;
      try
 {
   typedef __gnu_cxx::__alloc_traits<_Allocator> __traits;
   for (; __n > 0; --__n, (void) ++__cur)
     __traits::construct(__alloc, std::__addressof(*__cur), __x);
   return __cur;
 }
      catch(...)
 {
   std::_Destroy(__first, __cur, __alloc);
   throw;
 }
    }
  template<typename _ForwardIterator, typename _Size, typename _Tp,
    typename _Tp2>
    inline _ForwardIterator
    __uninitialized_fill_n_a(_ForwardIterator __first, _Size __n,
        const _Tp& __x, allocator<_Tp2>&)
    { return std::uninitialized_fill_n(__first, __n, __x); }
  template<typename _InputIterator1, typename _InputIterator2,
    typename _ForwardIterator, typename _Allocator>
    inline _ForwardIterator
    __uninitialized_copy_move(_InputIterator1 __first1,
         _InputIterator1 __last1,
         _InputIterator2 __first2,
         _InputIterator2 __last2,
         _ForwardIterator __result,
         _Allocator& __alloc)
    {
      _ForwardIterator __mid = std::__uninitialized_copy_a(__first1, __last1,
          __result,
          __alloc);
      try
 {
   return std::__uninitialized_move_a(__first2, __last2, __mid, __alloc);
 }
      catch(...)
 {
   std::_Destroy(__result, __mid, __alloc);
   throw;
 }
    }
  template<typename _InputIterator1, typename _InputIterator2,
    typename _ForwardIterator, typename _Allocator>
    inline _ForwardIterator
    __uninitialized_move_copy(_InputIterator1 __first1,
         _InputIterator1 __last1,
         _InputIterator2 __first2,
         _InputIterator2 __last2,
         _ForwardIterator __result,
         _Allocator& __alloc)
    {
      _ForwardIterator __mid = std::__uninitialized_move_a(__first1, __last1,
          __result,
          __alloc);
      try
 {
   return std::__uninitialized_copy_a(__first2, __last2, __mid, __alloc);
 }
      catch(...)
 {
   std::_Destroy(__result, __mid, __alloc);
   throw;
 }
    }
  template<typename _ForwardIterator, typename _Tp, typename _InputIterator,
    typename _Allocator>
    inline _ForwardIterator
    __uninitialized_fill_move(_ForwardIterator __result, _ForwardIterator __mid,
         const _Tp& __x, _InputIterator __first,
         _InputIterator __last, _Allocator& __alloc)
    {
      std::__uninitialized_fill_a(__result, __mid, __x, __alloc);
      try
 {
   return std::__uninitialized_move_a(__first, __last, __mid, __alloc);
 }
      catch(...)
 {
   std::_Destroy(__result, __mid, __alloc);
   throw;
 }
    }
  template<typename _InputIterator, typename _ForwardIterator, typename _Tp,
    typename _Allocator>
    inline void
    __uninitialized_move_fill(_InputIterator __first1, _InputIterator __last1,
         _ForwardIterator __first2,
         _ForwardIterator __last2, const _Tp& __x,
         _Allocator& __alloc)
    {
      _ForwardIterator __mid2 = std::__uninitialized_move_a(__first1, __last1,
           __first2,
           __alloc);
      try
 {
   std::__uninitialized_fill_a(__mid2, __last2, __x, __alloc);
 }
      catch(...)
 {
   std::_Destroy(__first2, __mid2, __alloc);
   throw;
 }
    }
  template<bool _TrivialValueType>
    struct __uninitialized_default_1
    {
      template<typename _ForwardIterator>
        static void
        __uninit_default(_ForwardIterator __first, _ForwardIterator __last)
        {
   _ForwardIterator __cur = __first;
   try
     {
       for (; __cur != __last; ++__cur)
  std::_Construct(std::__addressof(*__cur));
     }
   catch(...)
     {
       std::_Destroy(__first, __cur);
       throw;
     }
 }
    };
  template<>
    struct __uninitialized_default_1<true>
    {
      template<typename _ForwardIterator>
        static void
        __uninit_default(_ForwardIterator __first, _ForwardIterator __last)
        {
   typedef typename iterator_traits<_ForwardIterator>::value_type
     _ValueType;
   std::fill(__first, __last, _ValueType());
 }
    };
  template<bool _TrivialValueType>
    struct __uninitialized_default_n_1
    {
      template<typename _ForwardIterator, typename _Size>
        static _ForwardIterator
        __uninit_default_n(_ForwardIterator __first, _Size __n)
        {
   _ForwardIterator __cur = __first;
   try
     {
       for (; __n > 0; --__n, (void) ++__cur)
  std::_Construct(std::__addressof(*__cur));
       return __cur;
     }
   catch(...)
     {
       std::_Destroy(__first, __cur);
       throw;
     }
 }
    };
  template<>
    struct __uninitialized_default_n_1<true>
    {
      template<typename _ForwardIterator, typename _Size>
        static _ForwardIterator
        __uninit_default_n(_ForwardIterator __first, _Size __n)
        {
   typedef typename iterator_traits<_ForwardIterator>::value_type
     _ValueType;
   return std::fill_n(__first, __n, _ValueType());
 }
    };
  template<typename _ForwardIterator>
    inline void
    __uninitialized_default(_ForwardIterator __first,
       _ForwardIterator __last)
    {
      typedef typename iterator_traits<_ForwardIterator>::value_type
 _ValueType;
      const bool __assignable = is_copy_assignable<_ValueType>::value;
      std::__uninitialized_default_1<__is_trivial(_ValueType)
         && __assignable>::
 __uninit_default(__first, __last);
    }
  template<typename _ForwardIterator, typename _Size>
    inline _ForwardIterator
    __uninitialized_default_n(_ForwardIterator __first, _Size __n)
    {
      typedef typename iterator_traits<_ForwardIterator>::value_type
 _ValueType;
      const bool __assignable = is_copy_assignable<_ValueType>::value;
      return __uninitialized_default_n_1<__is_trivial(_ValueType)
           && __assignable>::
 __uninit_default_n(__first, __n);
    }
  template<typename _ForwardIterator, typename _Allocator>
    void
    __uninitialized_default_a(_ForwardIterator __first,
         _ForwardIterator __last,
         _Allocator& __alloc)
    {
      _ForwardIterator __cur = __first;
      try
 {
   typedef __gnu_cxx::__alloc_traits<_Allocator> __traits;
   for (; __cur != __last; ++__cur)
     __traits::construct(__alloc, std::__addressof(*__cur));
 }
      catch(...)
 {
   std::_Destroy(__first, __cur, __alloc);
   throw;
 }
    }
  template<typename _ForwardIterator, typename _Tp>
    inline void
    __uninitialized_default_a(_ForwardIterator __first,
         _ForwardIterator __last,
         allocator<_Tp>&)
    { std::__uninitialized_default(__first, __last); }
  template<typename _ForwardIterator, typename _Size, typename _Allocator>
    _ForwardIterator
    __uninitialized_default_n_a(_ForwardIterator __first, _Size __n,
    _Allocator& __alloc)
    {
      _ForwardIterator __cur = __first;
      try
 {
   typedef __gnu_cxx::__alloc_traits<_Allocator> __traits;
   for (; __n > 0; --__n, (void) ++__cur)
     __traits::construct(__alloc, std::__addressof(*__cur));
   return __cur;
 }
      catch(...)
 {
   std::_Destroy(__first, __cur, __alloc);
   throw;
 }
    }
  template<typename _ForwardIterator, typename _Size, typename _Tp>
    inline _ForwardIterator
    __uninitialized_default_n_a(_ForwardIterator __first, _Size __n,
    allocator<_Tp>&)
    { return std::__uninitialized_default_n(__first, __n); }
  template<bool _TrivialValueType>
    struct __uninitialized_default_novalue_1
    {
      template<typename _ForwardIterator>
 static void
 __uninit_default_novalue(_ForwardIterator __first,
     _ForwardIterator __last)
 {
   _ForwardIterator __cur = __first;
   try
     {
       for (; __cur != __last; ++__cur)
  std::_Construct_novalue(std::__addressof(*__cur));
     }
   catch(...)
     {
       std::_Destroy(__first, __cur);
       throw;
     }
 }
    };
  template<>
    struct __uninitialized_default_novalue_1<true>
    {
      template<typename _ForwardIterator>
        static void
        __uninit_default_novalue(_ForwardIterator __first,
     _ForwardIterator __last)
 {
 }
    };
  template<bool _TrivialValueType>
    struct __uninitialized_default_novalue_n_1
    {
      template<typename _ForwardIterator, typename _Size>
 static _ForwardIterator
 __uninit_default_novalue_n(_ForwardIterator __first, _Size __n)
 {
   _ForwardIterator __cur = __first;
   try
     {
       for (; __n > 0; --__n, (void) ++__cur)
  std::_Construct_novalue(std::__addressof(*__cur));
       return __cur;
     }
   catch(...)
     {
       std::_Destroy(__first, __cur);
       throw;
     }
 }
    };
  template<>
    struct __uninitialized_default_novalue_n_1<true>
    {
      template<typename _ForwardIterator, typename _Size>
 static _ForwardIterator
 __uninit_default_novalue_n(_ForwardIterator __first, _Size __n)
 { return std::next(__first, __n); }
    };
  template<typename _ForwardIterator>
    inline void
    __uninitialized_default_novalue(_ForwardIterator __first,
        _ForwardIterator __last)
    {
      typedef typename iterator_traits<_ForwardIterator>::value_type
 _ValueType;
      std::__uninitialized_default_novalue_1<
 is_trivially_default_constructible<_ValueType>::value>::
 __uninit_default_novalue(__first, __last);
    }
  template<typename _ForwardIterator, typename _Size>
    inline _ForwardIterator
    __uninitialized_default_novalue_n(_ForwardIterator __first, _Size __n)
    {
      typedef typename iterator_traits<_ForwardIterator>::value_type
 _ValueType;
      return __uninitialized_default_novalue_n_1<
 is_trivially_default_constructible<_ValueType>::value>::
 __uninit_default_novalue_n(__first, __n);
    }
  template<typename _InputIterator, typename _Size,
    typename _ForwardIterator>
    _ForwardIterator
    __uninitialized_copy_n(_InputIterator __first, _Size __n,
      _ForwardIterator __result, input_iterator_tag)
    {
      _ForwardIterator __cur = __result;
      try
 {
   for (; __n > 0; --__n, (void) ++__first, ++__cur)
     std::_Construct(std::__addressof(*__cur), *__first);
   return __cur;
 }
      catch(...)
 {
   std::_Destroy(__result, __cur);
   throw;
 }
    }
  template<typename _RandomAccessIterator, typename _Size,
    typename _ForwardIterator>
    inline _ForwardIterator
    __uninitialized_copy_n(_RandomAccessIterator __first, _Size __n,
      _ForwardIterator __result,
      random_access_iterator_tag)
    { return std::uninitialized_copy(__first, __first + __n, __result); }
  template<typename _InputIterator, typename _Size,
    typename _ForwardIterator>
    pair<_InputIterator, _ForwardIterator>
    __uninitialized_copy_n_pair(_InputIterator __first, _Size __n,
      _ForwardIterator __result, input_iterator_tag)
    {
      _ForwardIterator __cur = __result;
      try
 {
   for (; __n > 0; --__n, (void) ++__first, ++__cur)
     std::_Construct(std::__addressof(*__cur), *__first);
   return {__first, __cur};
 }
      catch(...)
 {
   std::_Destroy(__result, __cur);
   throw;
 }
    }
  template<typename _RandomAccessIterator, typename _Size,
    typename _ForwardIterator>
    inline pair<_RandomAccessIterator, _ForwardIterator>
    __uninitialized_copy_n_pair(_RandomAccessIterator __first, _Size __n,
      _ForwardIterator __result,
      random_access_iterator_tag)
    {
      auto __second_res = uninitialized_copy(__first, __first + __n, __result);
      auto __first_res = std::next(__first, __n);
      return {__first_res, __second_res};
    }
  template<typename _InputIterator, typename _Size, typename _ForwardIterator>
    inline _ForwardIterator
    uninitialized_copy_n(_InputIterator __first, _Size __n,
    _ForwardIterator __result)
    { return std::__uninitialized_copy_n(__first, __n, __result,
      std::__iterator_category(__first)); }
  template<typename _InputIterator, typename _Size, typename _ForwardIterator>
    inline pair<_InputIterator, _ForwardIterator>
    __uninitialized_copy_n_pair(_InputIterator __first, _Size __n,
         _ForwardIterator __result)
    {
      return
 std::__uninitialized_copy_n_pair(__first, __n, __result,
      std::__iterator_category(__first));
    }

}
namespace std
{

  template<typename _Tp>
    pair<_Tp*, ptrdiff_t>
    get_temporary_buffer(ptrdiff_t __len) noexcept
    {
      const ptrdiff_t __max =
 __gnu_cxx::__numeric_traits<ptrdiff_t>::__max / sizeof(_Tp);
      if (__len > __max)
 __len = __max;
      while (__len > 0)
 {
   _Tp* __tmp = static_cast<_Tp*>(::operator new(__len * sizeof(_Tp),
       std::nothrow));
   if (__tmp != 0)
     return std::pair<_Tp*, ptrdiff_t>(__tmp, __len);
   __len /= 2;
 }
      return std::pair<_Tp*, ptrdiff_t>(static_cast<_Tp*>(0), 0);
    }
  template<typename _Tp>
    inline void
    return_temporary_buffer(_Tp* __p)
    { ::operator delete(__p, std::nothrow); }
  template<typename _ForwardIterator, typename _Tp>
    class _Temporary_buffer
    {
     
    public:
      typedef _Tp value_type;
      typedef value_type* pointer;
      typedef pointer iterator;
      typedef ptrdiff_t size_type;
    protected:
      size_type _M_original_len;
      size_type _M_len;
      pointer _M_buffer;
    public:
      size_type
      size() const
      { return _M_len; }
      size_type
      requested_size() const
      { return _M_original_len; }
      iterator
      begin()
      { return _M_buffer; }
      iterator
      end()
      { return _M_buffer + _M_len; }
      _Temporary_buffer(_ForwardIterator __first, _ForwardIterator __last);
      ~_Temporary_buffer()
      {
 std::_Destroy(_M_buffer, _M_buffer + _M_len);
 std::return_temporary_buffer(_M_buffer);
      }
    private:
      _Temporary_buffer(const _Temporary_buffer&);
      void
      operator=(const _Temporary_buffer&);
    };
  template<bool>
    struct __uninitialized_construct_buf_dispatch
    {
      template<typename _Pointer, typename _ForwardIterator>
        static void
        __ucr(_Pointer __first, _Pointer __last,
       _ForwardIterator __seed)
        {
   if(__first == __last)
     return;
   _Pointer __cur = __first;
   try
     {
       std::_Construct(std::__addressof(*__first),
         std::move(*__seed));
       _Pointer __prev = __cur;
       ++__cur;
       for(; __cur != __last; ++__cur, ++__prev)
  std::_Construct(std::__addressof(*__cur),
    std::move(*__prev));
       *__seed = std::move(*__prev);
     }
   catch(...)
     {
       std::_Destroy(__first, __cur);
       throw;
     }
 }
    };
  template<>
    struct __uninitialized_construct_buf_dispatch<true>
    {
      template<typename _Pointer, typename _ForwardIterator>
        static void
        __ucr(_Pointer, _Pointer, _ForwardIterator) { }
    };
  template<typename _Pointer, typename _ForwardIterator>
    inline void
    __uninitialized_construct_buf(_Pointer __first, _Pointer __last,
      _ForwardIterator __seed)
    {
      typedef typename std::iterator_traits<_Pointer>::value_type
 _ValueType;
      std::__uninitialized_construct_buf_dispatch<
        __has_trivial_constructor(_ValueType)>::
   __ucr(__first, __last, __seed);
    }
  template<typename _ForwardIterator, typename _Tp>
    _Temporary_buffer<_ForwardIterator, _Tp>::
    _Temporary_buffer(_ForwardIterator __first, _ForwardIterator __last)
    : _M_original_len(std::distance(__first, __last)),
      _M_len(0), _M_buffer(0)
    {
      try
 {
   std::pair<pointer, size_type> __p(std::get_temporary_buffer<
         value_type>(_M_original_len));
   _M_buffer = __p.first;
   _M_len = __p.second;
   if (_M_buffer)
     std::__uninitialized_construct_buf(_M_buffer, _M_buffer + _M_len,
            __first);
 }
      catch(...)
 {
   std::return_temporary_buffer(_M_buffer);
   _M_buffer = 0;
   _M_len = 0;
   throw;
 }
    }

}
namespace std
{

  template <class _OutputIterator, class _Tp>
    class raw_storage_iterator
    : public iterator<output_iterator_tag, void, void, void, void>
    {
    protected:
      _OutputIterator _M_iter;
    public:
      explicit
      raw_storage_iterator(_OutputIterator __x)
      : _M_iter(__x) {}
      raw_storage_iterator&
      operator*() { return *this; }
      raw_storage_iterator&
      operator=(const _Tp& __element)
      {
 std::_Construct(std::__addressof(*_M_iter), __element);
 return *this;
      }
      raw_storage_iterator&
      operator=(_Tp&& __element)
      {
 std::_Construct(std::__addressof(*_M_iter), std::move(__element));
 return *this;
      }
      raw_storage_iterator&
      operator++()
      {
 ++_M_iter;
 return *this;
      }
      raw_storage_iterator
      operator++(int)
      {
 raw_storage_iterator __tmp = *this;
 ++_M_iter;
 return __tmp;
      }
      _OutputIterator base() const { return _M_iter; }
    };

}
       
       
namespace std
{

  template<class _CharT>
    struct char_traits;
  template<> struct char_traits<char>;
  template<> struct char_traits<wchar_t>;
  template<> struct char_traits<char16_t>;
  template<> struct char_traits<char32_t>;
namespace __cxx11 {
  template<typename _CharT, typename _Traits = char_traits<_CharT>,
           typename _Alloc = allocator<_CharT> >
    class basic_string;
  typedef basic_string<char> string;
  typedef basic_string<wchar_t> wstring;
  typedef basic_string<char16_t> u16string;
  typedef basic_string<char32_t> u32string;
}

}
       
       
#pragma pack(push,_CRT_PACKING)
extern "C" {
  struct _iobuf {
    char *_ptr;
    int _cnt;
    char *_base;
    int _flag;
    int _file;
    int _charbuf;
    int _bufsiz;
    char *_tmpfname;
  };
  typedef struct _iobuf FILE;
__attribute__ ((__dllimport__)) FILE *__attribute__((__cdecl__)) __acrt_iob_func(unsigned index);
  __attribute__ ((__dllimport__)) FILE *__attribute__((__cdecl__)) __iob_func(void);
  typedef unsigned long _fsize_t;
  struct _wfinddata32_t {
    unsigned attrib;
    __time32_t time_create;
    __time32_t time_access;
    __time32_t time_write;
    _fsize_t size;
    wchar_t name[260];
  };
  struct _wfinddata32i64_t {
    unsigned attrib;
    __time32_t time_create;
    __time32_t time_access;
    __time32_t time_write;
    __extension__ long long size;
    wchar_t name[260];
  };
  struct _wfinddata64i32_t {
    unsigned attrib;
    __time64_t time_create;
    __time64_t time_access;
    __time64_t time_write;
    _fsize_t size;
    wchar_t name[260];
  };
  struct _wfinddata64_t {
    unsigned attrib;
    __time64_t time_create;
    __time64_t time_access;
    __time64_t time_write;
    __extension__ long long size;
    wchar_t name[260];
  };
  extern unsigned short ** __imp__pctype;
  extern unsigned short ** __imp__wctype;
  extern unsigned short ** __imp__pwctype;
  int __attribute__((__cdecl__)) iswalpha(wint_t _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _iswalpha_l(wint_t _C,_locale_t _Locale);
  int __attribute__((__cdecl__)) iswupper(wint_t _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _iswupper_l(wint_t _C,_locale_t _Locale);
  int __attribute__((__cdecl__)) iswlower(wint_t _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _iswlower_l(wint_t _C,_locale_t _Locale);
  int __attribute__((__cdecl__)) iswdigit(wint_t _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _iswdigit_l(wint_t _C,_locale_t _Locale);
  int __attribute__((__cdecl__)) iswxdigit(wint_t _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _iswxdigit_l(wint_t _C,_locale_t _Locale);
  int __attribute__((__cdecl__)) iswspace(wint_t _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _iswspace_l(wint_t _C,_locale_t _Locale);
  int __attribute__((__cdecl__)) iswpunct(wint_t _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _iswpunct_l(wint_t _C,_locale_t _Locale);
  int __attribute__((__cdecl__)) iswalnum(wint_t _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _iswalnum_l(wint_t _C,_locale_t _Locale);
  int __attribute__((__cdecl__)) iswprint(wint_t _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _iswprint_l(wint_t _C,_locale_t _Locale);
  int __attribute__((__cdecl__)) iswgraph(wint_t _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _iswgraph_l(wint_t _C,_locale_t _Locale);
  int __attribute__((__cdecl__)) iswcntrl(wint_t _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _iswcntrl_l(wint_t _C,_locale_t _Locale);
  int __attribute__((__cdecl__)) iswascii(wint_t _C);
  int __attribute__((__cdecl__)) isleadbyte(int _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _isleadbyte_l(int _C,_locale_t _Locale);
  wint_t __attribute__((__cdecl__)) towupper(wint_t _C);
  __attribute__ ((__dllimport__)) wint_t __attribute__((__cdecl__)) _towupper_l(wint_t _C,_locale_t _Locale);
  wint_t __attribute__((__cdecl__)) towlower(wint_t _C);
  __attribute__ ((__dllimport__)) wint_t __attribute__((__cdecl__)) _towlower_l(wint_t _C,_locale_t _Locale);
  int __attribute__((__cdecl__)) iswctype(wint_t _C,wctype_t _Type);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _iswctype_l(wint_t _C,wctype_t _Type,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) __iswcsymf(wint_t _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _iswcsymf_l(wint_t _C,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) __iswcsym(wint_t _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _iswcsym_l(wint_t _C,_locale_t _Locale);
  int __attribute__((__cdecl__)) is_wctype(wint_t _C,wctype_t _Type);
  int __attribute__((__cdecl__)) iswblank(wint_t _C);
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wgetcwd(wchar_t *_DstBuf,int _SizeInWords);
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wgetdcwd(int _Drive,wchar_t *_DstBuf,int _SizeInWords);
  wchar_t *__attribute__((__cdecl__)) _wgetdcwd_nolock(int _Drive,wchar_t *_DstBuf,int _SizeInWords);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wchdir(const wchar_t *_Path);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wmkdir(const wchar_t *_Path);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wrmdir(const wchar_t *_Path);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _waccess(const wchar_t *_Filename,int _AccessMode);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wchmod(const wchar_t *_Filename,int _Mode);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wcreat(const wchar_t *_Filename,int _PermissionMode) ;
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wfindfirst32(const wchar_t *_Filename,struct _wfinddata32_t *_FindData);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wfindnext32(intptr_t _FindHandle,struct _wfinddata32_t *_FindData);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wunlink(const wchar_t *_Filename);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wrename(const wchar_t *_OldFilename,const wchar_t *_NewFilename);
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wmktemp(wchar_t *_TemplateName) ;
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wfindfirst32i64(const wchar_t *_Filename,struct _wfinddata32i64_t *_FindData);
  intptr_t __attribute__((__cdecl__)) _wfindfirst64i32(const wchar_t *_Filename,struct _wfinddata64i32_t *_FindData);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wfindfirst64(const wchar_t *_Filename,struct _wfinddata64_t *_FindData);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wfindnext32i64(intptr_t _FindHandle,struct _wfinddata32i64_t *_FindData);
  int __attribute__((__cdecl__)) _wfindnext64i32(intptr_t _FindHandle,struct _wfinddata64i32_t *_FindData);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wfindnext64(intptr_t _FindHandle,struct _wfinddata64_t *_FindData);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wsopen_s(int *_FileHandle,const wchar_t *_Filename,int _OpenFlag,int _ShareFlag,int _PermissionFlag);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wopen(const wchar_t *_Filename,int _OpenFlag,...) ;
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wsopen(const wchar_t *_Filename,int _OpenFlag,int _ShareFlag,...) ;
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wsetlocale(int _Category,const wchar_t *_Locale);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wexecl(const wchar_t *_Filename,const wchar_t *_ArgList,...);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wexecle(const wchar_t *_Filename,const wchar_t *_ArgList,...);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wexeclp(const wchar_t *_Filename,const wchar_t *_ArgList,...);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wexeclpe(const wchar_t *_Filename,const wchar_t *_ArgList,...);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wexecv(const wchar_t *_Filename,const wchar_t *const *_ArgList);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wexecve(const wchar_t *_Filename,const wchar_t *const *_ArgList,const wchar_t *const *_Env);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wexecvp(const wchar_t *_Filename,const wchar_t *const *_ArgList);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wexecvpe(const wchar_t *_Filename,const wchar_t *const *_ArgList,const wchar_t *const *_Env);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wspawnl(int _Mode,const wchar_t *_Filename,const wchar_t *_ArgList,...);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wspawnle(int _Mode,const wchar_t *_Filename,const wchar_t *_ArgList,...);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wspawnlp(int _Mode,const wchar_t *_Filename,const wchar_t *_ArgList,...);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wspawnlpe(int _Mode,const wchar_t *_Filename,const wchar_t *_ArgList,...);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wspawnv(int _Mode,const wchar_t *_Filename,const wchar_t *const *_ArgList);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wspawnve(int _Mode,const wchar_t *_Filename,const wchar_t *const *_ArgList,const wchar_t *const *_Env);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wspawnvp(int _Mode,const wchar_t *_Filename,const wchar_t *const *_ArgList);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wspawnvpe(int _Mode,const wchar_t *_Filename,const wchar_t *const *_ArgList,const wchar_t *const *_Env);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wsystem(const wchar_t *_Command);
  typedef unsigned short _ino_t;
  typedef unsigned short ino_t;
  typedef unsigned int _dev_t;
  typedef unsigned int dev_t;
  typedef long _off_t;
  typedef long off32_t;
  __extension__ typedef long long _off64_t;
  __extension__ typedef long long off64_t;
typedef off32_t off_t;
  struct _stat32 {
    _dev_t st_dev;
   _ino_t st_ino;
    unsigned short st_mode;
    short st_nlink;
    short st_uid;
    short st_gid;
    _dev_t st_rdev;
    _off_t st_size;
    __time32_t st_atime;
    __time32_t st_mtime;
    __time32_t st_ctime;
  };
  struct stat {
    _dev_t st_dev;
    _ino_t st_ino;
    unsigned short st_mode;
    short st_nlink;
    short st_uid;
    short st_gid;
    _dev_t st_rdev;
    _off_t st_size;
    time_t st_atime;
    time_t st_mtime;
    time_t st_ctime;
  };
  struct _stat32i64 {
    _dev_t st_dev;
    _ino_t st_ino;
    unsigned short st_mode;
    short st_nlink;
    short st_uid;
    short st_gid;
    _dev_t st_rdev;
    __extension__ long long st_size;
    __time32_t st_atime;
    __time32_t st_mtime;
    __time32_t st_ctime;
  };
  struct _stat64i32 {
    _dev_t st_dev;
    _ino_t st_ino;
    unsigned short st_mode;
    short st_nlink;
    short st_uid;
    short st_gid;
    _dev_t st_rdev;
    _off_t st_size;
    __time64_t st_atime;
    __time64_t st_mtime;
    __time64_t st_ctime;
  };
  struct _stat64 {
    _dev_t st_dev;
    _ino_t st_ino;
    unsigned short st_mode;
    short st_nlink;
    short st_uid;
    short st_gid;
    _dev_t st_rdev;
    __extension__ long long st_size;
    __time64_t st_atime;
    __time64_t st_mtime;
    __time64_t st_ctime;
  };
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wstat32(const wchar_t *_Name,struct _stat32 *_Stat);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wstat32i64(const wchar_t *_Name,struct _stat32i64 *_Stat);
  int __attribute__((__cdecl__)) _wstat64i32(const wchar_t *_Name,struct _stat64i32 *_Stat);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wstat64(const wchar_t *_Name,struct _stat64 *_Stat);
  __attribute__ ((__dllimport__)) wchar_t *_cgetws(wchar_t *_Buffer) ;
  __attribute__ ((__dllimport__)) wint_t __attribute__((__cdecl__)) _getwch(void);
  __attribute__ ((__dllimport__)) wint_t __attribute__((__cdecl__)) _getwche(void);
  __attribute__ ((__dllimport__)) wint_t __attribute__((__cdecl__)) _putwch(wchar_t _WCh);
  __attribute__ ((__dllimport__)) wint_t __attribute__((__cdecl__)) _ungetwch(wint_t _WCh);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _cputws(const wchar_t *_String);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _cwprintf(const wchar_t * __restrict__ _Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _cwscanf(const wchar_t * __restrict__ _Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _cwscanf_l(const wchar_t * __restrict__ _Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vcwprintf(const wchar_t * __restrict__ _Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _cwprintf_p(const wchar_t * __restrict__ _Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vcwprintf_p(const wchar_t * __restrict__ _Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _cwprintf_l(const wchar_t * __restrict__ _Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vcwprintf_l(const wchar_t * __restrict__ _Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _cwprintf_p_l(const wchar_t * __restrict__ _Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vcwprintf_p_l(const wchar_t * __restrict__ _Format,_locale_t _Locale,va_list _ArgList);
  wint_t __attribute__((__cdecl__)) _putwch_nolock(wchar_t _WCh);
  wint_t __attribute__((__cdecl__)) _getwch_nolock(void);
  wint_t __attribute__((__cdecl__)) _getwche_nolock(void);
  wint_t __attribute__((__cdecl__)) _ungetwch_nolock(wint_t _WCh);
                                                     __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_swscanf(const wchar_t * __restrict__ _Src,const wchar_t * __restrict__ _Format,...);
                                                     __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_vswscanf (const wchar_t * __restrict__ _Str,const wchar_t * __restrict__ Format,va_list argp);
                                                     __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __mingw_wscanf(const wchar_t * __restrict__ _Format,...);
                                                     __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __mingw_vwscanf(const wchar_t * __restrict__ Format, va_list argp);
                                                     __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_fwscanf(FILE * __restrict__ _File,const wchar_t * __restrict__ _Format,...);
                                                     __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_vfwscanf (FILE * __restrict__ fp, const wchar_t * __restrict__ Format,va_list argp);
                                                      __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_fwprintf(FILE * __restrict__ _File,const wchar_t * __restrict__ _Format,...);
                                                      __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __mingw_wprintf(const wchar_t * __restrict__ _Format,...);
                                                      __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_vfwprintf(FILE * __restrict__ _File,const wchar_t * __restrict__ _Format,va_list _ArgList);
                                                     __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __mingw_vwprintf(const wchar_t * __restrict__ _Format,va_list _ArgList);
                                                      __attribute__ ((__nonnull__ (3)))
  int __attribute__((__cdecl__)) __mingw_snwprintf (wchar_t * __restrict__ s, size_t n, const wchar_t * __restrict__ format, ...);
                                                      __attribute__ ((__nonnull__ (3)))
  int __attribute__((__cdecl__)) __mingw_vsnwprintf (wchar_t * __restrict__ , size_t, const wchar_t * __restrict__ , va_list);
                                                      __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_swprintf(wchar_t * __restrict__ , const wchar_t * __restrict__ , ...);
                                                      __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_vswprintf(wchar_t * __restrict__ , const wchar_t * __restrict__ ,va_list);
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
                                                     __attribute__ ((__nonnull__ (2)))
int swscanf(const wchar_t *__source, const wchar_t *__format, ...)
{
  int __retval;
  __builtin_va_list __local_argv; __builtin_va_start( __local_argv, __format );
  __retval = __mingw_vswscanf( __source, __format, __local_argv );
  __builtin_va_end( __local_argv );
  return __retval;
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
                                                     __attribute__ ((__nonnull__ (1)))
int wscanf(const wchar_t *__format, ...)
{
  int __retval;
  __builtin_va_list __local_argv; __builtin_va_start( __local_argv, __format );
  __retval = __mingw_vfwscanf( (__acrt_iob_func(0)), __format, __local_argv );
  __builtin_va_end( __local_argv );
  return __retval;
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
                                                     __attribute__ ((__nonnull__ (2)))
int fwscanf(FILE *__stream, const wchar_t *__format, ...)
{
  int __retval;
  __builtin_va_list __local_argv; __builtin_va_start( __local_argv, __format );
  __retval = __mingw_vfwscanf( __stream, __format, __local_argv );
  __builtin_va_end( __local_argv );
  return __retval;
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
                                                     __attribute__ ((__nonnull__ (2)))
int vswscanf (const wchar_t *__source, const wchar_t *__format, __builtin_va_list __local_argv)
{
  return __mingw_vswscanf( __source, __format, __local_argv );
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
                                                     __attribute__ ((__nonnull__ (1)))
int vwscanf(const wchar_t *__format, __builtin_va_list __local_argv)
{
  return __mingw_vfwscanf( (__acrt_iob_func(0)), __format, __local_argv );
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
                                                     __attribute__ ((__nonnull__ (2)))
int vfwscanf (FILE *__stream, const wchar_t *__format, __builtin_va_list __local_argv)
{
  return __mingw_vfwscanf( __stream, __format, __local_argv );
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
                                                      __attribute__ ((__nonnull__ (2)))
int fwprintf (FILE *__stream, const wchar_t *__format, ...)
{
  int __retval;
  __builtin_va_list __local_argv; __builtin_va_start( __local_argv, __format );
  __retval = __mingw_vfwprintf( __stream, __format, __local_argv );
  __builtin_va_end( __local_argv );
  return __retval;
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
                                                      __attribute__ ((__nonnull__ (1)))
int wprintf (const wchar_t *__format, ...)
{
  int __retval;
  __builtin_va_list __local_argv; __builtin_va_start( __local_argv, __format );
  __retval = __mingw_vfwprintf( (__acrt_iob_func(1)), __format, __local_argv );
  __builtin_va_end( __local_argv );
  return __retval;
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
                                                      __attribute__ ((__nonnull__ (2)))
int vfwprintf (FILE *__stream, const wchar_t *__format, __builtin_va_list __local_argv)
{
  return __mingw_vfwprintf( __stream, __format, __local_argv );
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
                                                      __attribute__ ((__nonnull__ (1)))
int vwprintf (const wchar_t *__format, __builtin_va_list __local_argv)
{
  return __mingw_vfwprintf( (__acrt_iob_func(1)), __format, __local_argv );
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
                                                      __attribute__ ((__nonnull__ (3)))
int snwprintf (wchar_t *__stream, size_t __n, const wchar_t *__format, ...)
{
  int __retval;
  __builtin_va_list __local_argv; __builtin_va_start( __local_argv, __format );
  __retval = __mingw_vsnwprintf( __stream, __n, __format, __local_argv );
  __builtin_va_end( __local_argv );
  return __retval;
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
                                                      __attribute__ ((__nonnull__ (3)))
int vsnwprintf (wchar_t *__stream, size_t __n, const wchar_t *__format, __builtin_va_list __local_argv)
{
  return __mingw_vsnwprintf( __stream, __n, __format, __local_argv );
}
  __attribute__ ((__dllimport__)) FILE *__attribute__((__cdecl__)) _wfsopen(const wchar_t *_Filename,const wchar_t *_Mode,int _ShFlag);
  wint_t __attribute__((__cdecl__)) fgetwc(FILE *_File);
  __attribute__ ((__dllimport__)) wint_t __attribute__((__cdecl__)) _fgetwchar(void);
  wint_t __attribute__((__cdecl__)) fputwc(wchar_t _Ch,FILE *_File);
  __attribute__ ((__dllimport__)) wint_t __attribute__((__cdecl__)) _fputwchar(wchar_t _Ch);
  wint_t __attribute__((__cdecl__)) getwc(FILE *_File);
  wint_t __attribute__((__cdecl__)) getwchar(void);
  wint_t __attribute__((__cdecl__)) putwc(wchar_t _Ch,FILE *_File);
  wint_t __attribute__((__cdecl__)) putwchar(wchar_t _Ch);
  wint_t __attribute__((__cdecl__)) ungetwc(wint_t _Ch,FILE *_File);
  wchar_t *__attribute__((__cdecl__)) fgetws(wchar_t * __restrict__ _Dst,int _SizeInWords,FILE * __restrict__ _File);
  int __attribute__((__cdecl__)) fputws(const wchar_t * __restrict__ _Str,FILE * __restrict__ _File);
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _getws(wchar_t *_String) ;
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _putws(const wchar_t *_Str);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _scwprintf(const wchar_t * __restrict__ _Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _swprintf_l(wchar_t * __restrict__ ,size_t _SizeInWords,const wchar_t * __restrict__ _Format,_locale_t _Locale,... ) ;
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _swprintf_c(wchar_t * __restrict__ _DstBuf,size_t _SizeInWords,const wchar_t * __restrict__ _Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vswprintf_c(wchar_t * __restrict__ _DstBuf,size_t _SizeInWords,const wchar_t * __restrict__ _Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snwprintf(wchar_t * __restrict__ _Dest,size_t _Count,const wchar_t * __restrict__ _Format,...) ;
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsnwprintf(wchar_t * __restrict__ _Dest,size_t _Count,const wchar_t * __restrict__ _Format,va_list _Args) ;
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fwprintf_p(FILE * __restrict__ _File,const wchar_t * __restrict__ _Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wprintf_p(const wchar_t * __restrict__ _Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vfwprintf_p(FILE * __restrict__ _File,const wchar_t * __restrict__ _Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vwprintf_p(const wchar_t * __restrict__ _Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _swprintf_p(wchar_t * __restrict__ _DstBuf,size_t _MaxCount,const wchar_t * __restrict__ _Format,...);
  __attribute__((dllimport)) int __attribute__((__cdecl__)) _vswprintf_p(wchar_t * __restrict__ _DstBuf,size_t _MaxCount,const wchar_t * __restrict__ _Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _scwprintf_p(const wchar_t * __restrict__ _Format,...);
  __attribute__((dllimport)) int __attribute__((__cdecl__)) _vscwprintf_p(const wchar_t * __restrict__ _Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wprintf_l(const wchar_t * __restrict__ _Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wprintf_p_l(const wchar_t * __restrict__ _Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vwprintf_l(const wchar_t * __restrict__ _Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vwprintf_p_l(const wchar_t * __restrict__ _Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fwprintf_l(FILE * __restrict__ _File,const wchar_t * __restrict__ _Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fwprintf_p_l(FILE * __restrict__ _File,const wchar_t * __restrict__ _Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vfwprintf_l(FILE * __restrict__ _File,const wchar_t * __restrict__ _Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vfwprintf_p_l(FILE * __restrict__ _File,const wchar_t * __restrict__ _Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _swprintf_c_l(wchar_t * __restrict__ _DstBuf,size_t _MaxCount,const wchar_t * __restrict__ _Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _swprintf_p_l(wchar_t * __restrict__ _DstBuf,size_t _MaxCount,const wchar_t * __restrict__ _Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vswprintf_c_l(wchar_t * __restrict__ _DstBuf,size_t _MaxCount,const wchar_t * __restrict__ _Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vswprintf_p_l(wchar_t * __restrict__ _DstBuf,size_t _MaxCount,const wchar_t * __restrict__ _Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _scwprintf_l(const wchar_t * __restrict__ _Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _scwprintf_p_l(const wchar_t * __restrict__ _Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vscwprintf_p_l(const wchar_t * __restrict__ _Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snwprintf_l(wchar_t * __restrict__ _DstBuf,size_t _MaxCount,const wchar_t * __restrict__ _Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsnwprintf_l(wchar_t * __restrict__ _DstBuf,size_t _MaxCount,const wchar_t * __restrict__ _Format,_locale_t _Locale,va_list _ArgList) ;
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _swprintf(wchar_t * __restrict__ _Dest,const wchar_t * __restrict__ _Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vswprintf(wchar_t * __restrict__ _Dest,const wchar_t * __restrict__ _Format,va_list _Args);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) __swprintf_l(wchar_t * __restrict__ _Dest,const wchar_t * __restrict__ _Format,_locale_t _Plocinfo,...) ;
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vswprintf_l(wchar_t * __restrict__ _Dest,size_t _MaxCount,const wchar_t * __restrict__ _Format,_locale_t _Locale,va_list _ArgList) ;
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) __vswprintf_l(wchar_t * __restrict__ _Dest,const wchar_t * __restrict__ _Format,_locale_t _Plocinfo,va_list _Args) ;
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
                                                      __attribute__ ((__nonnull__ (3)))
int vswprintf (wchar_t *__stream, size_t __count, const wchar_t *__format, __builtin_va_list __local_argv)
{
  return vsnwprintf( __stream, __count, __format, __local_argv );
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
                                                      __attribute__ ((__nonnull__ (3)))
int swprintf (wchar_t *__stream, size_t __count, const wchar_t *__format, ...)
{
  int __retval;
  __builtin_va_list __local_argv;
  __builtin_va_start( __local_argv, __format );
  __retval = vswprintf( __stream, __count, __format, __local_argv );
  __builtin_va_end( __local_argv );
  return __retval;
}
extern "C++" {
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
                                                      __attribute__ ((__nonnull__ (2)))
int vswprintf (wchar_t *__stream, const wchar_t *__format, __builtin_va_list __local_argv)
{
  return __mingw_vswprintf( __stream, __format, __local_argv );
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
                                                      __attribute__ ((__nonnull__ (2)))
int swprintf (wchar_t *__stream, const wchar_t *__format, ...)
{
  int __retval;
  __builtin_va_list __local_argv;
  __builtin_va_start( __local_argv, __format );
  __retval = vswprintf( __stream, __format, __local_argv );
  __builtin_va_end( __local_argv );
  return __retval;
}
}
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wtempnam(const wchar_t *_Directory,const wchar_t *_FilePrefix);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vscwprintf(const wchar_t * __restrict__ _Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vscwprintf_l(const wchar_t * __restrict__ _Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fwscanf_l(FILE * __restrict__ _File,const wchar_t * __restrict__ _Format,_locale_t _Locale,...) ;
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _swscanf_l(const wchar_t * __restrict__ _Src,const wchar_t * __restrict__ _Format,_locale_t _Locale,...) ;
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snwscanf(const wchar_t * __restrict__ _Src,size_t _MaxCount,const wchar_t * __restrict__ _Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snwscanf_l(const wchar_t * __restrict__ _Src,size_t _MaxCount,const wchar_t * __restrict__ _Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wscanf_l(const wchar_t * __restrict__ _Format,_locale_t _Locale,...) ;
  __attribute__ ((__dllimport__)) FILE *__attribute__((__cdecl__)) _wfdopen(int _FileHandle ,const wchar_t *_Mode);
  __attribute__ ((__dllimport__)) FILE *__attribute__((__cdecl__)) _wfopen(const wchar_t * __restrict__ _Filename,const wchar_t * __restrict__ _Mode) ;
  __attribute__ ((__dllimport__)) FILE *__attribute__((__cdecl__)) _wfreopen(const wchar_t * __restrict__ _Filename,const wchar_t * __restrict__ _Mode,FILE * __restrict__ _OldFile) ;
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _wperror(const wchar_t *_ErrMsg);
  __attribute__ ((__dllimport__)) FILE *__attribute__((__cdecl__)) _wpopen(const wchar_t *_Command,const wchar_t *_Mode);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wremove(const wchar_t *_Filename);
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wtmpnam(wchar_t *_Buffer);
  __attribute__ ((__dllimport__)) wint_t __attribute__((__cdecl__)) _fgetwc_nolock(FILE *_File);
  __attribute__ ((__dllimport__)) wint_t __attribute__((__cdecl__)) _fputwc_nolock(wchar_t _Ch,FILE *_File);
  __attribute__ ((__dllimport__)) wint_t __attribute__((__cdecl__)) _ungetwc_nolock(wint_t _Ch,FILE *_File);
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _itow(int _Value,wchar_t *_Dest,int _Radix) ;
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _ltow(long _Value,wchar_t *_Dest,int _Radix) ;
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _ultow(unsigned long _Value,wchar_t *_Dest,int _Radix) ;
  __attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) _wcstod_l(const wchar_t * __restrict__ _Str,wchar_t ** __restrict__ _EndPtr,_locale_t _Locale);
  double __attribute__((__cdecl__)) __mingw_wcstod(const wchar_t * __restrict__ _Str,wchar_t ** __restrict__ _EndPtr);
  float __attribute__((__cdecl__)) __mingw_wcstof(const wchar_t * __restrict__ nptr, wchar_t ** __restrict__ endptr);
  long double __attribute__((__cdecl__)) __mingw_wcstold(const wchar_t * __restrict__, wchar_t ** __restrict__);
  static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
  double __attribute__((__cdecl__)) wcstod(const wchar_t * __restrict__ _Str,wchar_t ** __restrict__ _EndPtr){
    return __mingw_wcstod(_Str,_EndPtr);
  }
  static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
  float __attribute__((__cdecl__)) wcstof(const wchar_t * __restrict__ _Str,wchar_t ** __restrict__ _EndPtr){
    return __mingw_wcstof(_Str,_EndPtr);
  }
  long double __attribute__((__cdecl__)) wcstold (const wchar_t * __restrict__, wchar_t ** __restrict__);
  long __attribute__((__cdecl__)) wcstol(const wchar_t * __restrict__ _Str,wchar_t ** __restrict__ _EndPtr,int _Radix);
  __attribute__ ((__dllimport__)) long __attribute__((__cdecl__)) _wcstol_l(const wchar_t * __restrict__ _Str,wchar_t ** __restrict__ _EndPtr,int _Radix,_locale_t _Locale);
  unsigned long __attribute__((__cdecl__)) wcstoul(const wchar_t * __restrict__ _Str,wchar_t ** __restrict__ _EndPtr,int _Radix);
  __attribute__ ((__dllimport__)) unsigned long __attribute__((__cdecl__)) _wcstoul_l(const wchar_t * __restrict__ _Str,wchar_t ** __restrict__ _EndPtr,int _Radix,_locale_t _Locale);
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wgetenv(const wchar_t *_VarName) ;
  __attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) _wtof(const wchar_t *_Str);
  __attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) _wtof_l(const wchar_t *_Str,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wtoi(const wchar_t *_Str);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wtoi_l(const wchar_t *_Str,_locale_t _Locale);
  __attribute__ ((__dllimport__)) long __attribute__((__cdecl__)) _wtol(const wchar_t *_Str);
  __attribute__ ((__dllimport__)) long __attribute__((__cdecl__)) _wtol_l(const wchar_t *_Str,_locale_t _Locale);
  __extension__ __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _i64tow(long long _Val,wchar_t *_DstBuf,int _Radix) ;
  __extension__ __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _ui64tow(unsigned long long _Val,wchar_t *_DstBuf,int _Radix);
  __extension__ __attribute__ ((__dllimport__)) long long __attribute__((__cdecl__)) _wtoi64(const wchar_t *_Str);
  __extension__ __attribute__ ((__dllimport__)) long long __attribute__((__cdecl__)) _wtoi64_l(const wchar_t *_Str,_locale_t _Locale);
  __extension__ __attribute__ ((__dllimport__)) long long __attribute__((__cdecl__)) _wcstoi64(const wchar_t *_Str,wchar_t **_EndPtr,int _Radix);
  __extension__ __attribute__ ((__dllimport__)) long long __attribute__((__cdecl__)) _wcstoi64_l(const wchar_t *_Str,wchar_t **_EndPtr,int _Radix,_locale_t _Locale);
  __extension__ __attribute__ ((__dllimport__)) unsigned long long __attribute__((__cdecl__)) _wcstoui64(const wchar_t *_Str,wchar_t **_EndPtr,int _Radix);
  __extension__ __attribute__ ((__dllimport__)) unsigned long long __attribute__((__cdecl__)) _wcstoui64_l(const wchar_t *_Str,wchar_t **_EndPtr,int _Radix,_locale_t _Locale);
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wfullpath(wchar_t *_FullPath,const wchar_t *_Path,size_t _SizeInWords);
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _wmakepath(wchar_t *_ResultPath,const wchar_t *_Drive,const wchar_t *_Dir,const wchar_t *_Filename,const wchar_t *_Ext);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wputenv(const wchar_t *_EnvString);
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _wsearchenv(const wchar_t *_Filename,const wchar_t *_EnvVar,wchar_t *_ResultPath) ;
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _wsplitpath(const wchar_t *_FullPath,wchar_t *_Drive,wchar_t *_Dir,wchar_t *_Filename,wchar_t *_Ext) ;
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wcsdup(const wchar_t *_Str);
  wchar_t *__attribute__((__cdecl__)) wcscat(wchar_t * __restrict__ _Dest,const wchar_t * __restrict__ _Source) ;
  wchar_t *__attribute__((__cdecl__)) wcschr(const wchar_t *_Str,wchar_t _Ch);
  int __attribute__((__cdecl__)) wcscmp(const wchar_t *_Str1,const wchar_t *_Str2);
  wchar_t *__attribute__((__cdecl__)) wcscpy(wchar_t * __restrict__ _Dest,const wchar_t * __restrict__ _Source) ;
  size_t __attribute__((__cdecl__)) wcscspn(const wchar_t *_Str,const wchar_t *_Control);
  size_t __attribute__((__cdecl__)) wcslen(const wchar_t *_Str);
  size_t __attribute__((__cdecl__)) wcsnlen(const wchar_t *_Src,size_t _MaxCount);
  wchar_t *__attribute__((__cdecl__)) wcsncat(wchar_t * __restrict__ _Dest,const wchar_t * __restrict__ _Source,size_t _Count) ;
  int __attribute__((__cdecl__)) wcsncmp(const wchar_t *_Str1,const wchar_t *_Str2,size_t _MaxCount);
  wchar_t *__attribute__((__cdecl__)) wcsncpy(wchar_t * __restrict__ _Dest,const wchar_t * __restrict__ _Source,size_t _Count) ;
  wchar_t *__attribute__((__cdecl__)) _wcsncpy_l(wchar_t * __restrict__ _Dest,const wchar_t * __restrict__ _Source,size_t _Count,_locale_t _Locale) ;
  wchar_t *__attribute__((__cdecl__)) wcspbrk(const wchar_t *_Str,const wchar_t *_Control);
  wchar_t *__attribute__((__cdecl__)) wcsrchr(const wchar_t *_Str,wchar_t _Ch);
  size_t __attribute__((__cdecl__)) wcsspn(const wchar_t *_Str,const wchar_t *_Control);
  wchar_t *__attribute__((__cdecl__)) wcsstr(const wchar_t *_Str,const wchar_t *_SubStr);
  wchar_t *__attribute__((__cdecl__)) wcstok(wchar_t * __restrict__ _Str,const wchar_t * __restrict__ _Delim) ;
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wcserror(int _ErrNum) ;
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) __wcserror(const wchar_t *_Str) ;
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wcsicmp(const wchar_t *_Str1,const wchar_t *_Str2);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wcsicmp_l(const wchar_t *_Str1,const wchar_t *_Str2,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wcsnicmp(const wchar_t *_Str1,const wchar_t *_Str2,size_t _MaxCount);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wcsnicmp_l(const wchar_t *_Str1,const wchar_t *_Str2,size_t _MaxCount,_locale_t _Locale);
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wcsnset(wchar_t *_Str,wchar_t _Val,size_t _MaxCount) ;
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wcsrev(wchar_t *_Str);
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wcsset(wchar_t *_Str,wchar_t _Val) ;
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wcslwr(wchar_t *_String) ;
  __attribute__ ((__dllimport__)) wchar_t *_wcslwr_l(wchar_t *_String,_locale_t _Locale) ;
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wcsupr(wchar_t *_String) ;
  __attribute__ ((__dllimport__)) wchar_t *_wcsupr_l(wchar_t *_String,_locale_t _Locale) ;
  size_t __attribute__((__cdecl__)) wcsxfrm(wchar_t * __restrict__ _Dst,const wchar_t * __restrict__ _Src,size_t _MaxCount);
  __attribute__ ((__dllimport__)) size_t __attribute__((__cdecl__)) _wcsxfrm_l(wchar_t * __restrict__ _Dst,const wchar_t * __restrict__ _Src,size_t _MaxCount,_locale_t _Locale);
  int __attribute__((__cdecl__)) wcscoll(const wchar_t *_Str1,const wchar_t *_Str2);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wcscoll_l(const wchar_t *_Str1,const wchar_t *_Str2,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wcsicoll(const wchar_t *_Str1,const wchar_t *_Str2);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wcsicoll_l(const wchar_t *_Str1,const wchar_t *_Str2,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wcsncoll(const wchar_t *_Str1,const wchar_t *_Str2,size_t _MaxCount);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wcsncoll_l(const wchar_t *_Str1,const wchar_t *_Str2,size_t _MaxCount,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wcsnicoll(const wchar_t *_Str1,const wchar_t *_Str2,size_t _MaxCount);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wcsnicoll_l(const wchar_t *_Str1,const wchar_t *_Str2,size_t _MaxCount,_locale_t _Locale);
  wchar_t *__attribute__((__cdecl__)) wcsdup(const wchar_t *_Str) ;
  int __attribute__((__cdecl__)) wcsicmp(const wchar_t *_Str1,const wchar_t *_Str2) ;
  int __attribute__((__cdecl__)) wcsnicmp(const wchar_t *_Str1,const wchar_t *_Str2,size_t _MaxCount) ;
  wchar_t *__attribute__((__cdecl__)) wcsnset(wchar_t *_Str,wchar_t _Val,size_t _MaxCount) ;
  wchar_t *__attribute__((__cdecl__)) wcsrev(wchar_t *_Str) ;
  wchar_t *__attribute__((__cdecl__)) wcsset(wchar_t *_Str,wchar_t _Val) ;
  wchar_t *__attribute__((__cdecl__)) wcslwr(wchar_t *_Str) ;
  wchar_t *__attribute__((__cdecl__)) wcsupr(wchar_t *_Str) ;
  int __attribute__((__cdecl__)) wcsicoll(const wchar_t *_Str1,const wchar_t *_Str2) ;
  struct tm {
    int tm_sec;
    int tm_min;
    int tm_hour;
    int tm_mday;
    int tm_mon;
    int tm_year;
    int tm_wday;
    int tm_yday;
    int tm_isdst;
  };
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wasctime(const struct tm *_Tm);
  __attribute__((dllimport)) errno_t __attribute__((__cdecl__)) _wasctime_s (wchar_t *_Buf,size_t _SizeInWords,const struct tm *_Tm);
  wchar_t *__attribute__((__cdecl__)) _wctime32(const __time32_t *_Time) ;
  __attribute__((dllimport)) errno_t __attribute__((__cdecl__)) _wctime32_s (wchar_t *_Buf,size_t _SizeInWords,const __time32_t *_Time);
  size_t __attribute__((__cdecl__)) wcsftime(wchar_t * __restrict__ _Buf,size_t _SizeInWords,const wchar_t * __restrict__ _Format,const struct tm * __restrict__ _Tm);
  __attribute__ ((__dllimport__)) size_t __attribute__((__cdecl__)) _wcsftime_l(wchar_t * __restrict__ _Buf,size_t _SizeInWords,const wchar_t * __restrict__ _Format,const struct tm * __restrict__ _Tm,_locale_t _Locale);
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wstrdate(wchar_t *_Buffer) ;
  __attribute__((dllimport)) errno_t __attribute__((__cdecl__)) _wstrdate_s (wchar_t *_Buf,size_t _SizeInWords);
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wstrtime(wchar_t *_Buffer) ;
  __attribute__((dllimport)) errno_t __attribute__((__cdecl__)) _wstrtime_s (wchar_t *_Buf,size_t _SizeInWords);
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wctime64(const __time64_t *_Time) ;
  __attribute__((dllimport)) errno_t __attribute__((__cdecl__)) _wctime64_s (wchar_t *_Buf,size_t _SizeInWords,const __time64_t *_Time);
  wchar_t *__attribute__((__cdecl__)) _wctime(const time_t *_Time) ;
  errno_t __attribute__((__cdecl__)) _wctime_s(wchar_t *, size_t, const time_t *);
  typedef int mbstate_t;
  typedef wchar_t _Wint_t;
  wint_t __attribute__((__cdecl__)) btowc(int);
  size_t __attribute__((__cdecl__)) mbrlen(const char * __restrict__ _Ch,size_t _SizeInBytes,mbstate_t * __restrict__ _State);
  size_t __attribute__((__cdecl__)) mbrtowc(wchar_t * __restrict__ _DstCh,const char * __restrict__ _SrcCh,size_t _SizeInBytes,mbstate_t * __restrict__ _State);
  size_t __attribute__((__cdecl__)) mbsrtowcs(wchar_t * __restrict__ _Dest,const char ** __restrict__ _PSrc,size_t _Count,mbstate_t * __restrict__ _State) ;
  size_t __attribute__((__cdecl__)) wcrtomb(char * __restrict__ _Dest,wchar_t _Source,mbstate_t * __restrict__ _State) ;
  size_t __attribute__((__cdecl__)) wcsrtombs(char * __restrict__ _Dest,const wchar_t ** __restrict__ _PSource,size_t _Count,mbstate_t * __restrict__ _State) ;
  int __attribute__((__cdecl__)) wctob(wint_t _WCh);
  wchar_t *__attribute__((__cdecl__)) wmemset(wchar_t *s, wchar_t c, size_t n);
  wchar_t *__attribute__((__cdecl__)) wmemchr(const wchar_t *s, wchar_t c, size_t n);
  int __attribute__((__cdecl__)) wmemcmp(const wchar_t *s1, const wchar_t *s2,size_t n);
  wchar_t *__attribute__((__cdecl__)) wmemcpy(wchar_t * __restrict__ s1,const wchar_t * __restrict__ s2,size_t n) ;
  wchar_t * __attribute__((__cdecl__)) wmempcpy (wchar_t *_Dst, const wchar_t *_Src, size_t _Size);
  wchar_t *__attribute__((__cdecl__)) wmemmove(wchar_t *s1, const wchar_t *s2, size_t n) ;
  int __attribute__((__cdecl__)) fwide(FILE *stream,int mode);
  int __attribute__((__cdecl__)) mbsinit(const mbstate_t *ps);
  __extension__ long long __attribute__((__cdecl__)) wcstoll(const wchar_t * __restrict__ nptr,wchar_t ** __restrict__ endptr, int base);
  __extension__ unsigned long long __attribute__((__cdecl__)) wcstoull(const wchar_t * __restrict__ nptr,wchar_t ** __restrict__ endptr, int base);
  void *__attribute__((__cdecl__)) memmove(void *_Dst,const void *_Src,size_t _MaxCount);
  void *__attribute__((__cdecl__)) memcpy(void * __restrict__ _Dst,const void * __restrict__ _Src,size_t _MaxCount) ;
int __attribute__((__cdecl__)) __mingw_str_wide_utf8 (const wchar_t * const wptr, char **mbptr, size_t * buflen);
int __attribute__((__cdecl__)) __mingw_str_utf8_wide (const char *const mbptr, wchar_t ** wptr, size_t * buflen);
void __attribute__((__cdecl__)) __mingw_str_free(void *ptr);
}
#pragma pack(pop)
extern "C" {
  __attribute__((dllimport)) errno_t __attribute__((__cdecl__)) _waccess_s (const wchar_t *_Filename,int _AccessMode);
  __attribute__((dllimport)) errno_t __attribute__((__cdecl__)) _wmktemp_s (wchar_t *_TemplateName,size_t _SizeInWords);
  __attribute__((dllimport)) errno_t __attribute__((__cdecl__)) _cgetws_s (wchar_t *_Buffer,size_t _SizeInWords,size_t *_SizeRead);
  __attribute__((dllimport)) int __attribute__((__cdecl__)) _cwprintf_s (const wchar_t *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _cwscanf_s(const wchar_t *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _cwscanf_s_l(const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__((dllimport)) int __attribute__((__cdecl__)) _vcwprintf_s (const wchar_t *_Format,va_list _ArgList);
  __attribute__((dllimport)) int __attribute__((__cdecl__)) _cwprintf_s_l (const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__((dllimport)) int __attribute__((__cdecl__)) _vcwprintf_s_l (const wchar_t *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _getws_s(wchar_t *_Str,size_t _SizeInWords);
  extern "C++" { template <size_t __size> inline wchar_t* __attribute__((__cdecl__)) _getws_s(wchar_t (&_DstBuf)[__size]) { return _getws_s(_DstBuf,__size); } }
  int __attribute__((__cdecl__)) fwprintf_s(FILE *_File,const wchar_t *_Format,...);
  int __attribute__((__cdecl__)) wprintf_s(const wchar_t *_Format,...);
  int __attribute__((__cdecl__)) vfwprintf_s(FILE *_File,const wchar_t *_Format,va_list _ArgList);
  int __attribute__((__cdecl__)) vwprintf_s(const wchar_t *_Format,va_list _ArgList);
  int __attribute__((__cdecl__)) vswprintf_s(wchar_t *_Dst,size_t _SizeInWords,const wchar_t *_Format,va_list _ArgList);
  int __attribute__((__cdecl__)) swprintf_s(wchar_t *_Dst,size_t _SizeInWords,const wchar_t *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsnwprintf_s(wchar_t *_DstBuf,size_t _DstSizeInWords,size_t _MaxCount,const wchar_t *_Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snwprintf_s(wchar_t *_DstBuf,size_t _DstSizeInWords,size_t _MaxCount,const wchar_t *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wprintf_s_l(const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vwprintf_s_l(const wchar_t *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fwprintf_s_l(FILE *_File,const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vfwprintf_s_l(FILE *_File,const wchar_t *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _swprintf_s_l(wchar_t *_DstBuf,size_t _DstSize,const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vswprintf_s_l(wchar_t *_DstBuf,size_t _DstSize,const wchar_t *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snwprintf_s_l(wchar_t *_DstBuf,size_t _DstSize,size_t _MaxCount,const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsnwprintf_s_l(wchar_t *_DstBuf,size_t _DstSize,size_t _MaxCount,const wchar_t *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fwscanf_s_l(FILE *_File,const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _swscanf_s_l(const wchar_t *_Src,const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) swscanf_s(const wchar_t *_Src,const wchar_t *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snwscanf_s(const wchar_t *_Src,size_t _MaxCount,const wchar_t *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snwscanf_s_l(const wchar_t *_Src,size_t _MaxCount,const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wscanf_s_l(const wchar_t *_Format,_locale_t _Locale,...);
  extern "C++" { template <size_t __size> inline int __attribute__((__cdecl__)) vswprintf_s(wchar_t (&_Dst)[__size], const wchar_t* _Format, va_list _ArgList) { return vswprintf_s(_Dst,__size,_Format,_ArgList); } }
  extern "C++" { template <size_t __size> inline int __attribute__((__cdecl__)) swprintf_s(wchar_t (&_Dst)[__size], const wchar_t* _Format, ...) { va_list __vaargs; __builtin_va_start(__vaargs,_Format); int __retval = vswprintf_s(_Dst,__size,_Format,__vaargs); __builtin_va_end(__vaargs); return __retval; } }
  extern "C++" { template <size_t __size> inline int __attribute__((__cdecl__)) _vsnwprintf_s(wchar_t (&_DstBuf)[__size], size_t _MaxCount, const wchar_t* _Format, va_list _ArgList) { return _vsnwprintf_s(_DstBuf,__size,_MaxCount,_Format,_ArgList); } }
  extern "C++" { template <size_t __size> inline int __attribute__((__cdecl__)) _snwprintf_s(wchar_t (&_DstBuf)[__size], size_t _MaxCount, const wchar_t* _Format, ...) { va_list __vaargs; __builtin_va_start(__vaargs,_Format); int __retval = _vsnwprintf_s(_DstBuf,__size,_MaxCount,_Format,__vaargs); __builtin_va_end(__vaargs); return __retval; } }
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wfopen_s(FILE **_File,const wchar_t *_Filename,const wchar_t *_Mode);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wfreopen_s(FILE **_File,const wchar_t *_Filename,const wchar_t *_Mode,FILE *_OldFile);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wtmpnam_s(wchar_t *_DstBuf,size_t _SizeInWords);
  extern "C++" { template <size_t __size> inline errno_t __attribute__((__cdecl__)) _wtmpnam_s(wchar_t (&_DstBuf)[__size]) { return _wtmpnam_s(_DstBuf,__size); } }
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _itow_s (int _Val,wchar_t *_DstBuf,size_t _SizeInWords,int _Radix);
  extern "C++" { template <size_t __size> inline errno_t __attribute__((__cdecl__)) _itow_s(int _Val, wchar_t (&_DstBuf)[__size], int _Radix) { return _itow_s(_Val, _DstBuf, __size, _Radix); } }
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _ltow_s (long _Val,wchar_t *_DstBuf,size_t _SizeInWords,int _Radix);
  extern "C++" { template <size_t __size> inline errno_t __attribute__((__cdecl__)) _ltow_s(long _Val, wchar_t (&_DstBuf)[__size], int _Radix) { return _ltow_s(_Val, _DstBuf, __size, _Radix); } }
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _ultow_s (unsigned long _Val,wchar_t *_DstBuf,size_t _SizeInWords,int _Radix);
  extern "C++" { template <size_t __size> inline errno_t __attribute__((__cdecl__)) _ultow_s(unsigned long _Val, wchar_t (&_DstBuf)[__size], int _Radix) { return _ultow_s(_Val, _DstBuf, __size, _Radix); } }
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wgetenv_s(size_t *_ReturnSize,wchar_t *_DstBuf,size_t _DstSizeInWords,const wchar_t *_VarName);
  extern "C++" { template <size_t __size> inline errno_t __attribute__((__cdecl__)) _wgetenv_s(size_t* _ReturnSize, wchar_t (&_DstBuf)[__size], const wchar_t* _VarName) { return _wgetenv_s(_ReturnSize, _DstBuf, __size, _VarName); } }
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wdupenv_s(wchar_t **_Buffer,size_t *_BufferSizeInWords,const wchar_t *_VarName);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _i64tow_s(long long _Val,wchar_t *_DstBuf,size_t _SizeInWords,int _Radix);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _ui64tow_s(unsigned long long _Val,wchar_t *_DstBuf,size_t _SizeInWords,int _Radix);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wmakepath_s(wchar_t *_PathResult,size_t _SizeInWords,const wchar_t *_Drive,const wchar_t *_Dir,const wchar_t *_Filename,const wchar_t *_Ext);
  extern "C++" { template <size_t __size> inline errno_t __attribute__((__cdecl__)) _wmakepath_s(wchar_t (&_PathResult)[__size], const wchar_t* _Drive, const wchar_t* _Dir, const wchar_t* _Filename, const wchar_t* _Ext) { return _wmakepath_s(_PathResult,__size,_Drive,_Dir,_Filename,_Ext); } }
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wputenv_s(const wchar_t *_Name,const wchar_t *_Value);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wsearchenv_s(const wchar_t *_Filename,const wchar_t *_EnvVar,wchar_t *_ResultPath,size_t _SizeInWords);
  extern "C++" { template <size_t __size> inline errno_t __attribute__((__cdecl__)) _wsearchenv_s(const wchar_t* _Filename, const wchar_t* _EnvVar, wchar_t (&_ResultPath)[__size]) { return _wsearchenv_s(_Filename, _EnvVar, _ResultPath, __size); } }
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wsplitpath_s(const wchar_t *_FullPath,wchar_t *_Drive,size_t _DriveSizeInWords,wchar_t *_Dir,size_t _DirSizeInWords,wchar_t *_Filename,size_t _FilenameSizeInWords,wchar_t *_Ext,size_t _ExtSizeInWords);
  extern "C++" { template <size_t __drive_size, size_t __dir_size, size_t __name_size, size_t __ext_size> inline errno_t __attribute__((__cdecl__)) _wsplitpath_s(const wchar_t *_Dest, wchar_t (&__drive)[__drive_size], wchar_t (&__dir)[__dir_size], wchar_t (&__name)[__name_size], wchar_t (&__ext)[__ext_size]) { return _wsplitpath_s(_Dest, __drive, __drive_size, __dir, __dir_size, __name, __name_size, __ext, __ext_size); } }
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) wcstok_s(wchar_t *_Str,const wchar_t *_Delim,wchar_t **_Context);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wcserror_s(wchar_t *_Buf,size_t _SizeInWords,int _ErrNum);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) __wcserror_s(wchar_t *_Buffer,size_t _SizeInWords,const wchar_t *_ErrMsg);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wcsnset_s(wchar_t *_Dst,size_t _DstSizeInWords,wchar_t _Val,size_t _MaxCount);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wcsset_s(wchar_t *_Str,size_t _SizeInWords,wchar_t _Val);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wcslwr_s(wchar_t *_Str,size_t _SizeInWords);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wcslwr_s_l(wchar_t *_Str,size_t _SizeInWords,_locale_t _Locale);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wcsupr_s(wchar_t *_Str,size_t _Size);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wcsupr_s_l(wchar_t *_Str,size_t _Size,_locale_t _Locale);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) wcscat_s(wchar_t *_Dst, rsize_t _DstSize, const wchar_t *_Src);
  extern "C++" { template <size_t __size> inline errno_t __attribute__((__cdecl__)) wcscat_s(wchar_t (&_Dest)[__size], const wchar_t * _Source) { return wcscat_s(_Dest,__size,_Source); } }
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) wcscpy_s(wchar_t *_Dst, rsize_t _DstSize, const wchar_t *_Src);
  extern "C++" { template <size_t __size> inline errno_t __attribute__((__cdecl__)) wcscpy_s(wchar_t (&_Dest)[__size], const wchar_t * _Source) { return wcscpy_s(_Dest,__size,_Source); } }
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) wcsncat_s(wchar_t *_Dst,size_t _DstSizeInChars,const wchar_t *_Src,size_t _MaxCount);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wcsncat_s_l(wchar_t *_Dst,size_t _DstSizeInChars,const wchar_t *_Src,size_t _MaxCount,_locale_t _Locale);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) wcsncpy_s(wchar_t *_Dst,size_t _DstSizeInChars,const wchar_t *_Src,size_t _MaxCount);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wcsncpy_s_l(wchar_t *_Dst,size_t _DstSizeInChars,const wchar_t *_Src,size_t _MaxCount,_locale_t _Locale);
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wcstok_s_l(wchar_t *_Str,const wchar_t *_Delim,wchar_t **_Context,_locale_t _Locale);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wcsset_s_l(wchar_t *_Str,size_t _SizeInChars,unsigned int _Val,_locale_t _Locale);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wcsnset_s_l(wchar_t *_Str,size_t _SizeInChars,unsigned int _Val, size_t _Count,_locale_t _Locale);
  inline __attribute__((__always_inline__)) size_t __attribute__((__cdecl__)) wcsnlen_s(const wchar_t * _src, size_t _count) {
    return _src ? wcsnlen(_src, _count) : 0;
  }
  __attribute__((dllimport)) errno_t __attribute__((__cdecl__)) _wasctime_s (wchar_t *_Buf,size_t _SizeInWords,const struct tm *_Tm);
  __attribute__((dllimport)) errno_t __attribute__((__cdecl__)) _wctime32_s (wchar_t *_Buf,size_t _SizeInWords,const __time32_t *_Time);
  __attribute__((dllimport)) errno_t __attribute__((__cdecl__)) _wstrdate_s (wchar_t *_Buf,size_t _SizeInWords);
  __attribute__((dllimport)) errno_t __attribute__((__cdecl__)) _wstrtime_s (wchar_t *_Buf,size_t _SizeInWords);
  __attribute__((dllimport)) errno_t __attribute__((__cdecl__)) _wctime64_s (wchar_t *_Buf,size_t _SizeInWords,const __time64_t *_Time);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) mbsrtowcs_s(size_t *_Retval,wchar_t *_Dst,size_t _SizeInWords,const char **_PSrc,size_t _N,mbstate_t *_State);
  extern "C++" { template <size_t __size> inline errno_t __attribute__((__cdecl__)) mbsrtowcs_s(size_t* _Retval, wchar_t (&_Dst)[__size], const char** _PSrc, size_t _N, mbstate_t _State) { return mbsrtowcs_s(_Retval, _Dst, __size, _PSrc, _N, _State); } }
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) wcrtomb_s(size_t *_Retval,char *_Dst,size_t _SizeInBytes,wchar_t _Ch,mbstate_t *_State);
  extern "C++" { template <size_t __size> inline errno_t __attribute__((__cdecl__)) wcrtomb_s(size_t* _Retval, char (&_Dst)[__size], wchar_t _Ch, mbstate_t _State) { return wcrtomb_s(_Retval, _Dst, __size, _Ch, _State); } }
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) wcsrtombs_s(size_t *_Retval,char *_Dst,size_t _SizeInBytes,const wchar_t **_Src,size_t _Size,mbstate_t *_State);
  extern "C++" { template <size_t __size> inline errno_t __attribute__((__cdecl__)) wcsrtombs_s(size_t _Retval, char (&_Dst)[__size], const wchar_t** _Src, size_t _Size, mbstate_t _State) { return wcsrtombs_s(_Retval, _Dst, __size, _Src, _Size, _State); } }
  __attribute__((dllimport)) errno_t __attribute__((__cdecl__)) wmemcpy_s (wchar_t *_dest,size_t _numberOfElements,const wchar_t *_src,size_t _count);
  __attribute__((dllimport)) errno_t __attribute__((__cdecl__)) wmemmove_s(wchar_t *_dest,size_t _numberOfElements,const wchar_t *_src,size_t _count);
}
namespace std
{
  using ::mbstate_t;
}
namespace std
{

  using ::wint_t;
  using ::btowc;
  using ::fgetwc;
  using ::fgetws;
  using ::fputwc;
  using ::fputws;
  using ::fwide;
  using ::fwprintf;
  using ::fwscanf;
  using ::getwc;
  using ::getwchar;
  using ::mbrlen;
  using ::mbrtowc;
  using ::mbsinit;
  using ::mbsrtowcs;
  using ::putwc;
  using ::putwchar;
  using ::swprintf;
  using ::swscanf;
  using ::ungetwc;
  using ::vfwprintf;
  using ::vfwscanf;
  using ::vswprintf;
  using ::vswscanf;
  using ::vwprintf;
  using ::vwscanf;
  using ::wcrtomb;
  using ::wcscat;
  using ::wcscmp;
  using ::wcscoll;
  using ::wcscpy;
  using ::wcscspn;
  using ::wcsftime;
  using ::wcslen;
  using ::wcsncat;
  using ::wcsncmp;
  using ::wcsncpy;
  using ::wcsrtombs;
  using ::wcsspn;
  using ::wcstod;
  using ::wcstof;
  using ::wcstok;
  using ::wcstol;
  using ::wcstoul;
  using ::wcsxfrm;
  using ::wctob;
  using ::wmemcmp;
  using ::wmemcpy;
  using ::wmemmove;
  using ::wmemset;
  using ::wprintf;
  using ::wscanf;
  using ::wcschr;
  using ::wcspbrk;
  using ::wcsrchr;
  using ::wcsstr;
  using ::wmemchr;
  inline wchar_t*
  wcschr(wchar_t* __p, wchar_t __c)
  { return wcschr(const_cast<const wchar_t*>(__p), __c); }
  inline wchar_t*
  wcspbrk(wchar_t* __s1, const wchar_t* __s2)
  { return wcspbrk(const_cast<const wchar_t*>(__s1), __s2); }
  inline wchar_t*
  wcsrchr(wchar_t* __p, wchar_t __c)
  { return wcsrchr(const_cast<const wchar_t*>(__p), __c); }
  inline wchar_t*
  wcsstr(wchar_t* __s1, const wchar_t* __s2)
  { return wcsstr(const_cast<const wchar_t*>(__s1), __s2); }
  inline wchar_t*
  wmemchr(wchar_t* __p, wchar_t __c, size_t __n)
  { return wmemchr(const_cast<const wchar_t*>(__p), __c, __n); }

}
namespace __gnu_cxx
{
  using ::wcstold;
  using ::wcstoll;
  using ::wcstoull;
}
namespace std
{
  using ::__gnu_cxx::wcstold;
  using ::__gnu_cxx::wcstoll;
  using ::__gnu_cxx::wcstoull;
}
namespace std
{
  using std::wcstof;
  using std::vfwscanf;
  using std::vswscanf;
  using std::vwscanf;
  using std::wcstold;
  using std::wcstoll;
  using std::wcstoull;
}
namespace std
{

  typedef long long streamoff;
  typedef ptrdiff_t streamsize;
  template<typename _StateT>
    class fpos
    {
    private:
      streamoff _M_off;
      _StateT _M_state;
    public:
      fpos()
      : _M_off(0), _M_state() { }
      fpos(streamoff __off)
      : _M_off(__off), _M_state() { }
      operator streamoff() const { return _M_off; }
      void
      state(_StateT __st)
      { _M_state = __st; }
      _StateT
      state() const
      { return _M_state; }
      fpos&
      operator+=(streamoff __off)
      {
 _M_off += __off;
 return *this;
      }
      fpos&
      operator-=(streamoff __off)
      {
 _M_off -= __off;
 return *this;
      }
      fpos
      operator+(streamoff __off) const
      {
 fpos __pos(*this);
 __pos += __off;
 return __pos;
      }
      fpos
      operator-(streamoff __off) const
      {
 fpos __pos(*this);
 __pos -= __off;
 return __pos;
      }
      streamoff
      operator-(const fpos& __other) const
      { return _M_off - __other._M_off; }
    };
  template<typename _StateT>
    inline bool
    operator==(const fpos<_StateT>& __lhs, const fpos<_StateT>& __rhs)
    { return streamoff(__lhs) == streamoff(__rhs); }
  template<typename _StateT>
    inline bool
    operator!=(const fpos<_StateT>& __lhs, const fpos<_StateT>& __rhs)
    { return streamoff(__lhs) != streamoff(__rhs); }
  typedef fpos<mbstate_t> streampos;
  typedef fpos<mbstate_t> wstreampos;
  typedef fpos<mbstate_t> u16streampos;
  typedef fpos<mbstate_t> u32streampos;

}
namespace std
{

  class ios_base;
  template<typename _CharT, typename _Traits = char_traits<_CharT> >
    class basic_ios;
  template<typename _CharT, typename _Traits = char_traits<_CharT> >
    class basic_streambuf;
  template<typename _CharT, typename _Traits = char_traits<_CharT> >
    class basic_istream;
  template<typename _CharT, typename _Traits = char_traits<_CharT> >
    class basic_ostream;
  template<typename _CharT, typename _Traits = char_traits<_CharT> >
    class basic_iostream;
namespace __cxx11 {
  template<typename _CharT, typename _Traits = char_traits<_CharT>,
     typename _Alloc = allocator<_CharT> >
    class basic_stringbuf;
  template<typename _CharT, typename _Traits = char_traits<_CharT>,
    typename _Alloc = allocator<_CharT> >
    class basic_istringstream;
  template<typename _CharT, typename _Traits = char_traits<_CharT>,
    typename _Alloc = allocator<_CharT> >
    class basic_ostringstream;
  template<typename _CharT, typename _Traits = char_traits<_CharT>,
    typename _Alloc = allocator<_CharT> >
    class basic_stringstream;
}
  template<typename _CharT, typename _Traits = char_traits<_CharT> >
    class basic_filebuf;
  template<typename _CharT, typename _Traits = char_traits<_CharT> >
    class basic_ifstream;
  template<typename _CharT, typename _Traits = char_traits<_CharT> >
    class basic_ofstream;
  template<typename _CharT, typename _Traits = char_traits<_CharT> >
    class basic_fstream;
  template<typename _CharT, typename _Traits = char_traits<_CharT> >
    class istreambuf_iterator;
  template<typename _CharT, typename _Traits = char_traits<_CharT> >
    class ostreambuf_iterator;
  typedef basic_ios<char> ios;
  typedef basic_streambuf<char> streambuf;
  typedef basic_istream<char> istream;
  typedef basic_ostream<char> ostream;
  typedef basic_iostream<char> iostream;
  typedef basic_stringbuf<char> stringbuf;
  typedef basic_istringstream<char> istringstream;
  typedef basic_ostringstream<char> ostringstream;
  typedef basic_stringstream<char> stringstream;
  typedef basic_filebuf<char> filebuf;
  typedef basic_ifstream<char> ifstream;
  typedef basic_ofstream<char> ofstream;
  typedef basic_fstream<char> fstream;
  typedef basic_ios<wchar_t> wios;
  typedef basic_streambuf<wchar_t> wstreambuf;
  typedef basic_istream<wchar_t> wistream;
  typedef basic_ostream<wchar_t> wostream;
  typedef basic_iostream<wchar_t> wiostream;
  typedef basic_stringbuf<wchar_t> wstringbuf;
  typedef basic_istringstream<wchar_t> wistringstream;
  typedef basic_ostringstream<wchar_t> wostringstream;
  typedef basic_stringstream<wchar_t> wstringstream;
  typedef basic_filebuf<wchar_t> wfilebuf;
  typedef basic_ifstream<wchar_t> wifstream;
  typedef basic_ofstream<wchar_t> wofstream;
  typedef basic_fstream<wchar_t> wfstream;

}
       
#pragma GCC visibility push(default)
extern "C" {
}
__extension__
typedef long long _pid_t;
typedef _pid_t pid_t;
typedef unsigned short _mode_t;
typedef _mode_t mode_t;
typedef unsigned int useconds_t;
struct timespec {
  time_t tv_sec;
  long tv_nsec;
};
struct itimerspec {
  struct timespec it_interval;
  struct timespec it_value;
};
__extension__
typedef unsigned long long _sigset_t;
extern "C" {
__attribute__ ((__dllimport__)) char **__attribute__((__cdecl__)) __p__acmdln(void);
__attribute__ ((__dllimport__)) wchar_t **__attribute__((__cdecl__)) __p__wcmdln(void);
typedef void (__attribute__((__cdecl__)) *_PVFV)(void);
typedef int (__attribute__((__cdecl__)) *_PIFV)(void);
typedef void (__attribute__((__cdecl__)) *_PVFI)(int);
typedef struct _onexit_table_t {
    _PVFV* _first;
    _PVFV* _last;
    _PVFV* _end;
} _onexit_table_t;
typedef int (__attribute__((__cdecl__)) *_onexit_t)(void);
__attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _initialize_onexit_table(_onexit_table_t*);
__attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _register_onexit_function(_onexit_table_t*,_onexit_t);
__attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _execute_onexit_table(_onexit_table_t*);
}
extern "C" {
  __attribute__ ((__dllimport__)) uintptr_t __attribute__((__cdecl__)) _beginthread(void (__attribute__((__cdecl__)) *_StartAddress) (void *),unsigned _StackSize,void *_ArgList);
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _endthread(void) __attribute__ ((__noreturn__));
  __attribute__ ((__dllimport__)) uintptr_t __attribute__((__cdecl__)) _beginthreadex(void *_Security,unsigned _StackSize,unsigned ( *_StartAddress) (void *),void *_ArgList,unsigned _InitFlag,unsigned *_ThrdAddr);
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _endthreadex(unsigned _Retval) __attribute__ ((__noreturn__));
  void __attribute__((__cdecl__)) __attribute__ ((__nothrow__)) exit(int _Code) __attribute__ ((__noreturn__));
  void __attribute__((__cdecl__)) __attribute__ ((__nothrow__)) _exit(int _Code) __attribute__ ((__noreturn__));
  void __attribute__((__cdecl__)) _Exit(int) __attribute__ ((__noreturn__));
       
  void __attribute__((__cdecl__)) __attribute__ ((__noreturn__)) abort(void);
       
  void __attribute__((__cdecl__)) __attribute__ ((__nothrow__)) _cexit(void);
  void __attribute__((__cdecl__)) __attribute__ ((__nothrow__)) _c_exit(void);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _getpid(void);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _cwait(int *_TermStat,intptr_t _ProcHandle,int _Action);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _execl(const char *_Filename,const char *_ArgList,...);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _execle(const char *_Filename,const char *_ArgList,...);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _execlp(const char *_Filename,const char *_ArgList,...);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _execlpe(const char *_Filename,const char *_ArgList,...);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _execv(const char *_Filename,const char *const *_ArgList);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _execve(const char *_Filename,const char *const *_ArgList,const char *const *_Env);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _execvp(const char *_Filename,const char *const *_ArgList);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _execvpe(const char *_Filename,const char *const *_ArgList,const char *const *_Env);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _spawnl(int _Mode,const char *_Filename,const char *_ArgList,...);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _spawnle(int _Mode,const char *_Filename,const char *_ArgList,...);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _spawnlp(int _Mode,const char *_Filename,const char *_ArgList,...);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _spawnlpe(int _Mode,const char *_Filename,const char *_ArgList,...);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _spawnv(int _Mode,const char *_Filename,const char *const *_ArgList);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _spawnve(int _Mode,const char *_Filename,const char *const *_ArgList,const char *const *_Env);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _spawnvp(int _Mode,const char *_Filename,const char *const *_ArgList);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _spawnvpe(int _Mode,const char *_Filename,const char *const *_ArgList,const char *const *_Env);
  int __attribute__((__cdecl__)) system(const char *_Command);
  void __attribute__((__cdecl__)) __security_init_cookie(void);
  void __attribute__((__cdecl__)) __security_check_cookie(uintptr_t _StackCookie);
  __attribute__ ((__noreturn__)) void __attribute__((__cdecl__)) __report_gsfailure(uintptr_t _StackCookie);
  extern uintptr_t __security_cookie;
  intptr_t __attribute__((__cdecl__)) _loaddll(char *_Filename);
  int __attribute__((__cdecl__)) _unloaddll(intptr_t _Handle);
  int (__attribute__((__cdecl__)) *__attribute__((__cdecl__)) _getdllprocaddr(intptr_t _Handle,char *_ProcedureName,intptr_t _Ordinal))(void);
  intptr_t __attribute__((__cdecl__)) cwait(int *_TermStat,intptr_t _ProcHandle,int _Action) ;
  int __attribute__((__cdecl__)) execl(const char *_Filename,const char *_ArgList,...) ;
  int __attribute__((__cdecl__)) execle(const char *_Filename,const char *_ArgList,...) ;
  int __attribute__((__cdecl__)) execlp(const char *_Filename,const char *_ArgList,...) ;
  int __attribute__((__cdecl__)) execlpe(const char *_Filename,const char *_ArgList,...) ;
  intptr_t __attribute__((__cdecl__)) spawnl(int,const char *_Filename,const char *_ArgList,...) ;
  intptr_t __attribute__((__cdecl__)) spawnle(int,const char *_Filename,const char *_ArgList,...) ;
  intptr_t __attribute__((__cdecl__)) spawnlp(int,const char *_Filename,const char *_ArgList,...) ;
  intptr_t __attribute__((__cdecl__)) spawnlpe(int,const char *_Filename,const char *_ArgList,...) ;
  int __attribute__((__cdecl__)) getpid(void) ;
  int __attribute__((__cdecl__)) execv(const char *_Filename,char *const _ArgList[]) ;
  int __attribute__((__cdecl__)) execve(const char *_Filename,char *const _ArgList[],char *const _Env[]) ;
  int __attribute__((__cdecl__)) execvp(const char *_Filename,char *const _ArgList[]) ;
  int __attribute__((__cdecl__)) execvpe(const char *_Filename,char *const _ArgList[],char *const _Env[]) ;
  intptr_t __attribute__((__cdecl__)) spawnv(int,const char *_Filename,char *const _ArgList[]) ;
  intptr_t __attribute__((__cdecl__)) spawnve(int,const char *_Filename,char *const _ArgList[],char *const _Env[]) ;
  intptr_t __attribute__((__cdecl__)) spawnvp(int,const char *_Filename,char *const _ArgList[]) ;
  intptr_t __attribute__((__cdecl__)) spawnvpe(int,const char *_Filename,char *const _ArgList[],char *const _Env[]) ;
}
extern "C" {
  typedef int sig_atomic_t;
  typedef void (*__p_sig_fn_t)(int);
  extern void **__attribute__((__cdecl__)) __pxcptinfoptrs(void);
  __p_sig_fn_t __attribute__((__cdecl__)) signal(int _SigNum,__p_sig_fn_t _Func);
  int __attribute__((__cdecl__)) raise(int _SigNum);
}
#pragma pack(push,_CRT_PACKING)
extern "C" {
  struct __timeb32 {
    __time32_t time;
    unsigned short millitm;
    short timezone;
    short dstflag;
  };
  struct timeb {
    time_t time;
    unsigned short millitm;
    short timezone;
    short dstflag;
  };
  struct __timeb64 {
    __time64_t time;
    unsigned short millitm;
    short timezone;
    short dstflag;
  };
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _ftime64(struct __timeb64 *_Time);
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _ftime(struct __timeb64 *);
  void __attribute__((__cdecl__)) ftime (struct timeb *);
}
#pragma pack(pop)
extern "C" {
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _ftime_s(struct __timeb32 *_Time);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _ftime64_s(struct __timeb64 *_Time);
}
extern "C" {
void * pthread_timechange_handler_np(void * dummy);
int pthread_delay_np (const struct timespec *interval);
int pthread_num_processors_np(void);
int pthread_set_num_processors_np(int n);
typedef long pthread_once_t;
typedef unsigned pthread_mutexattr_t;
typedef unsigned pthread_key_t;
typedef void *pthread_barrierattr_t;
typedef int pthread_condattr_t;
typedef int pthread_rwlockattr_t;
typedef uintptr_t pthread_t;
typedef struct _pthread_cleanup _pthread_cleanup;
struct _pthread_cleanup
{
    void (*func)(void *);
    void *arg;
    _pthread_cleanup *next;
};
struct sched_param {
  int sched_priority;
};
int sched_yield(void);
int sched_get_priority_min(int pol);
int sched_get_priority_max(int pol);
int sched_getscheduler(pid_t pid);
int sched_setscheduler(pid_t pid, int pol, const struct sched_param *param);
typedef struct pthread_attr_t pthread_attr_t;
struct pthread_attr_t
{
    unsigned p_state;
    void *stack;
    size_t s_size;
    struct sched_param param;
};
int pthread_attr_setschedparam(pthread_attr_t *attr, const struct sched_param *param);
int pthread_attr_getschedparam(const pthread_attr_t *attr, struct sched_param *param);
int pthread_getschedparam(pthread_t thread, int *pol, struct sched_param *param);
int pthread_setschedparam(pthread_t thread, int pol, const struct sched_param *param);
int pthread_attr_setschedpolicy (pthread_attr_t *attr, int pol);
int pthread_attr_getschedpolicy (const pthread_attr_t *attr, int *pol);
typedef void *pthread_spinlock_t;
typedef void *pthread_mutex_t;
typedef void *pthread_cond_t;
typedef void *pthread_rwlock_t;
typedef void *pthread_barrier_t;
extern void (**_pthread_key_dest)(void *);
int pthread_key_create(pthread_key_t *key, void (* dest)(void *));
int pthread_key_delete(pthread_key_t key);
void * pthread_getspecific(pthread_key_t key);
int pthread_setspecific(pthread_key_t key, const void *value);
pthread_t pthread_self(void);
int pthread_once(pthread_once_t *o, void (*func)(void));
void pthread_testcancel(void);
int pthread_equal(pthread_t t1, pthread_t t2);
void pthread_tls_init(void);
void _pthread_cleanup_dest(pthread_t t);
int pthread_get_concurrency(int *val);
int pthread_set_concurrency(int val);
void pthread_exit(void *res);
void _pthread_invoke_cancel(void);
int pthread_cancel(pthread_t t);
int pthread_kill(pthread_t t, int sig);
unsigned _pthread_get_state(const pthread_attr_t *attr, unsigned flag);
int _pthread_set_state(pthread_attr_t *attr, unsigned flag, unsigned val);
int pthread_setcancelstate(int state, int *oldstate);
int pthread_setcanceltype(int type, int *oldtype);
int pthread_create_wrapper(void *args);
int pthread_create(pthread_t *th, const pthread_attr_t *attr, void *(* func)(void *), void *arg);
int pthread_join(pthread_t t, void **res);
int pthread_detach(pthread_t t);
int pthread_setname_np(pthread_t thread, const char *name);
int pthread_getname_np(pthread_t thread, char *name, size_t len);
int pthread_rwlock_init(pthread_rwlock_t *rwlock_, const pthread_rwlockattr_t *attr);
int pthread_rwlock_wrlock(pthread_rwlock_t *l);
int pthread_rwlock_timedwrlock(pthread_rwlock_t *rwlock, const struct timespec *ts);
int pthread_rwlock_rdlock(pthread_rwlock_t *l);
int pthread_rwlock_timedrdlock(pthread_rwlock_t *l, const struct timespec *ts);
int pthread_rwlock_unlock(pthread_rwlock_t *l);
int pthread_rwlock_tryrdlock(pthread_rwlock_t *l);
int pthread_rwlock_trywrlock(pthread_rwlock_t *l);
int pthread_rwlock_destroy (pthread_rwlock_t *l);
int pthread_cond_init(pthread_cond_t *cv, const pthread_condattr_t *a);
int pthread_cond_destroy(pthread_cond_t *cv);
int pthread_cond_signal (pthread_cond_t *cv);
int pthread_cond_broadcast (pthread_cond_t *cv);
int pthread_cond_wait (pthread_cond_t *cv, pthread_mutex_t *external_mutex);
int pthread_cond_timedwait(pthread_cond_t *cv, pthread_mutex_t *external_mutex, const struct timespec *t);
int pthread_cond_timedwait_relative_np(pthread_cond_t *cv, pthread_mutex_t *external_mutex, const struct timespec *t);
int pthread_mutex_lock(pthread_mutex_t *m);
int pthread_mutex_timedlock(pthread_mutex_t *m, const struct timespec *ts);
int pthread_mutex_unlock(pthread_mutex_t *m);
int pthread_mutex_trylock(pthread_mutex_t *m);
int pthread_mutex_init(pthread_mutex_t *m, const pthread_mutexattr_t *a);
int pthread_mutex_destroy(pthread_mutex_t *m);
int pthread_barrier_destroy(pthread_barrier_t *b);
int pthread_barrier_init(pthread_barrier_t *b, const void *attr, unsigned int count);
int pthread_barrier_wait(pthread_barrier_t *b);
int pthread_spin_init(pthread_spinlock_t *l, int pshared);
int pthread_spin_destroy(pthread_spinlock_t *l);
int pthread_spin_lock(pthread_spinlock_t *l);
int pthread_spin_trylock(pthread_spinlock_t *l);
int pthread_spin_unlock(pthread_spinlock_t *l);
int pthread_attr_init(pthread_attr_t *attr);
int pthread_attr_destroy(pthread_attr_t *attr);
int pthread_attr_setdetachstate(pthread_attr_t *a, int flag);
int pthread_attr_getdetachstate(const pthread_attr_t *a, int *flag);
int pthread_attr_setinheritsched(pthread_attr_t *a, int flag);
int pthread_attr_getinheritsched(const pthread_attr_t *a, int *flag);
int pthread_attr_setscope(pthread_attr_t *a, int flag);
int pthread_attr_getscope(const pthread_attr_t *a, int *flag);
int pthread_attr_getstackaddr(const pthread_attr_t *attr, void **stack);
int pthread_attr_setstackaddr(pthread_attr_t *attr, void *stack);
int pthread_attr_getstacksize(const pthread_attr_t *attr, size_t *size);
int pthread_attr_setstacksize(pthread_attr_t *attr, size_t size);
int pthread_mutexattr_init(pthread_mutexattr_t *a);
int pthread_mutexattr_destroy(pthread_mutexattr_t *a);
int pthread_mutexattr_gettype(const pthread_mutexattr_t *a, int *type);
int pthread_mutexattr_settype(pthread_mutexattr_t *a, int type);
int pthread_mutexattr_getpshared(const pthread_mutexattr_t *a, int *type);
int pthread_mutexattr_setpshared(pthread_mutexattr_t * a, int type);
int pthread_mutexattr_getprotocol(const pthread_mutexattr_t *a, int *type);
int pthread_mutexattr_setprotocol(pthread_mutexattr_t *a, int type);
int pthread_mutexattr_getprioceiling(const pthread_mutexattr_t *a, int * prio);
int pthread_mutexattr_setprioceiling(pthread_mutexattr_t *a, int prio);
int pthread_getconcurrency(void);
int pthread_setconcurrency(int new_level);
int pthread_condattr_destroy(pthread_condattr_t *a);
int pthread_condattr_init(pthread_condattr_t *a);
int pthread_condattr_getpshared(const pthread_condattr_t *a, int *s);
int pthread_condattr_setpshared(pthread_condattr_t *a, int s);
typedef int clockid_t;
int pthread_condattr_getclock (const pthread_condattr_t *attr,
       clockid_t *clock_id);
int pthread_condattr_setclock(pthread_condattr_t *attr,
       clockid_t clock_id);
int __pthread_clock_nanosleep(clockid_t clock_id, int flags, const struct timespec *rqtp, struct timespec *rmtp);
int pthread_barrierattr_init(void **attr);
int pthread_barrierattr_destroy(void **attr);
int pthread_barrierattr_setpshared(void **attr, int s);
int pthread_barrierattr_getpshared(void **attr, int *s);
struct _pthread_cleanup ** pthread_getclean (void);
void * pthread_gethandle (pthread_t t);
void * pthread_getevent ();
unsigned long long _pthread_rel_time_in_ms(const struct timespec *ts);
unsigned long long _pthread_time_in_ms(void);
unsigned long long _pthread_time_in_ms_from_timespec(const struct timespec *ts);
int _pthread_tryjoin (pthread_t t, void **res);
int pthread_rwlockattr_destroy(pthread_rwlockattr_t *a);
int pthread_rwlockattr_getpshared(pthread_rwlockattr_t *a, int *s);
int pthread_rwlockattr_init(pthread_rwlockattr_t *a);
int pthread_rwlockattr_setpshared(pthread_rwlockattr_t *a, int s);
}
typedef pthread_t __gthread_t;
typedef pthread_key_t __gthread_key_t;
typedef pthread_once_t __gthread_once_t;
typedef pthread_mutex_t __gthread_mutex_t;
typedef pthread_mutex_t __gthread_recursive_mutex_t;
typedef pthread_cond_t __gthread_cond_t;
typedef struct timespec __gthread_time_t;



























static inline int
__gthread_active_p (void)
{
  return 1;
}
static inline int
__gthread_create (__gthread_t *__threadid, void *(*__func) (void*),
    void *__args)
{
  return pthread_create (__threadid, __null, __func, __args);
}
static inline int
__gthread_join (__gthread_t __threadid, void **__value_ptr)
{
  return pthread_join (__threadid, __value_ptr);
}
static inline int
__gthread_detach (__gthread_t __threadid)
{
  return pthread_detach (__threadid);
}
static inline int
__gthread_equal (__gthread_t __t1, __gthread_t __t2)
{
  return pthread_equal (__t1, __t2);
}
static inline __gthread_t
__gthread_self (void)
{
  return pthread_self ();
}
static inline int
__gthread_yield (void)
{
  return sched_yield ();
}
static inline int
__gthread_once (__gthread_once_t *__once, void (*__func) (void))
{
  if (__gthread_active_p ())
    return pthread_once (__once, __func);
  else
    return -1;
}
static inline int
__gthread_key_create (__gthread_key_t *__key, void (*__dtor) (void *))
{
  return pthread_key_create (__key, __dtor);
}
static inline int
__gthread_key_delete (__gthread_key_t __key)
{
  return pthread_key_delete (__key);
}
static inline void *
__gthread_getspecific (__gthread_key_t __key)
{
  return pthread_getspecific (__key);
}
static inline int
__gthread_setspecific (__gthread_key_t __key, const void *__ptr)
{
  return pthread_setspecific (__key, __ptr);
}
static inline void
__gthread_mutex_init_function (__gthread_mutex_t *__mutex)
{
  if (__gthread_active_p ())
    pthread_mutex_init (__mutex, __null);
}
static inline int
__gthread_mutex_destroy (__gthread_mutex_t *__mutex)
{
  if (__gthread_active_p ())
    return pthread_mutex_destroy (__mutex);
  else
    return 0;
}
static inline int
__gthread_mutex_lock (__gthread_mutex_t *__mutex)
{
  if (__gthread_active_p ())
    return pthread_mutex_lock (__mutex);
  else
    return 0;
}
static inline int
__gthread_mutex_trylock (__gthread_mutex_t *__mutex)
{
  if (__gthread_active_p ())
    return pthread_mutex_trylock (__mutex);
  else
    return 0;
}
static inline int
__gthread_mutex_timedlock (__gthread_mutex_t *__mutex,
      const __gthread_time_t *__abs_timeout)
{
  if (__gthread_active_p ())
    return pthread_mutex_timedlock (__mutex, __abs_timeout);
  else
    return 0;
}
static inline int
__gthread_mutex_unlock (__gthread_mutex_t *__mutex)
{
  if (__gthread_active_p ())
    return pthread_mutex_unlock (__mutex);
  else
    return 0;
}
static inline int
__gthread_recursive_mutex_init_function (__gthread_recursive_mutex_t *__mutex)
{
  if (__gthread_active_p ())
    {
      pthread_mutexattr_t __attr;
      int __r;
      __r = pthread_mutexattr_init (&__attr);
      if (!__r)
 __r = pthread_mutexattr_settype (&__attr,
         2);
      if (!__r)
 __r = pthread_mutex_init (__mutex, &__attr);
      if (!__r)
 __r = pthread_mutexattr_destroy (&__attr);
      return __r;
    }
  return 0;
}
static inline int
__gthread_recursive_mutex_lock (__gthread_recursive_mutex_t *__mutex)
{
  return __gthread_mutex_lock (__mutex);
}
static inline int
__gthread_recursive_mutex_trylock (__gthread_recursive_mutex_t *__mutex)
{
  return __gthread_mutex_trylock (__mutex);
}
static inline int
__gthread_recursive_mutex_timedlock (__gthread_recursive_mutex_t *__mutex,
         const __gthread_time_t *__abs_timeout)
{
  return __gthread_mutex_timedlock (__mutex, __abs_timeout);
}
static inline int
__gthread_recursive_mutex_unlock (__gthread_recursive_mutex_t *__mutex)
{
  return __gthread_mutex_unlock (__mutex);
}
static inline int
__gthread_recursive_mutex_destroy (__gthread_recursive_mutex_t *__mutex)
{
  return __gthread_mutex_destroy (__mutex);
}
static inline int
__gthread_cond_broadcast (__gthread_cond_t *__cond)
{
  return pthread_cond_broadcast (__cond);
}
static inline int
__gthread_cond_signal (__gthread_cond_t *__cond)
{
  return pthread_cond_signal (__cond);
}
static inline int
__gthread_cond_wait (__gthread_cond_t *__cond, __gthread_mutex_t *__mutex)
{
  return pthread_cond_wait (__cond, __mutex);
}
static inline int
__gthread_cond_timedwait (__gthread_cond_t *__cond, __gthread_mutex_t *__mutex,
     const __gthread_time_t *__abs_timeout)
{
  return pthread_cond_timedwait (__cond, __mutex, __abs_timeout);
}
static inline int
__gthread_cond_wait_recursive (__gthread_cond_t *__cond,
          __gthread_recursive_mutex_t *__mutex)
{
  return __gthread_cond_wait (__cond, __mutex);
}
static inline int
__gthread_cond_destroy (__gthread_cond_t* __cond)
{
  return pthread_cond_destroy (__cond);
}
#pragma GCC visibility pop
typedef int _Atomic_word;
namespace __gnu_cxx
{

  static inline _Atomic_word
  __exchange_and_add(volatile _Atomic_word* __mem, int __val)
  { return __atomic_fetch_add(__mem, __val, 4); }
  static inline void
  __atomic_add(volatile _Atomic_word* __mem, int __val)
  { __atomic_fetch_add(__mem, __val, 4); }
  static inline _Atomic_word
  __exchange_and_add_single(_Atomic_word* __mem, int __val)
  {
    _Atomic_word __result = *__mem;
    *__mem += __val;
    return __result;
  }
  static inline void
  __atomic_add_single(_Atomic_word* __mem, int __val)
  { *__mem += __val; }
  static inline _Atomic_word
  __attribute__ ((__unused__))
  __exchange_and_add_dispatch(_Atomic_word* __mem, int __val)
  {
    if (__gthread_active_p())
      return __exchange_and_add(__mem, __val);
    else
      return __exchange_and_add_single(__mem, __val);
  }
  static inline void
  __attribute__ ((__unused__))
  __atomic_add_dispatch(_Atomic_word* __mem, int __val)
  {
    if (__gthread_active_p())
      __atomic_add(__mem, __val);
    else
      __atomic_add_single(__mem, __val);
  }

}
       
namespace __gnu_cxx
{

  enum _Lock_policy { _S_single, _S_mutex, _S_atomic };
  static const _Lock_policy __default_lock_policy =
  _S_atomic;
  class __concurrence_lock_error : public std::exception
  {
  public:
    virtual char const*
    what() const throw()
    { return "__gnu_cxx::__concurrence_lock_error"; }
  };
  class __concurrence_unlock_error : public std::exception
  {
  public:
    virtual char const*
    what() const throw()
    { return "__gnu_cxx::__concurrence_unlock_error"; }
  };
  class __concurrence_broadcast_error : public std::exception
  {
  public:
    virtual char const*
    what() const throw()
    { return "__gnu_cxx::__concurrence_broadcast_error"; }
  };
  class __concurrence_wait_error : public std::exception
  {
  public:
    virtual char const*
    what() const throw()
    { return "__gnu_cxx::__concurrence_wait_error"; }
  };
  inline void
  __throw_concurrence_lock_error()
  { (throw (__concurrence_lock_error())); }
  inline void
  __throw_concurrence_unlock_error()
  { (throw (__concurrence_unlock_error())); }
  inline void
  __throw_concurrence_broadcast_error()
  { (throw (__concurrence_broadcast_error())); }
  inline void
  __throw_concurrence_wait_error()
  { (throw (__concurrence_wait_error())); }
  class __mutex
  {
  private:
    __gthread_mutex_t _M_mutex;
    __mutex(const __mutex&);
    __mutex& operator=(const __mutex&);
  public:
    __mutex()
    {
      if (__gthread_active_p())
 __gthread_mutex_init_function(&_M_mutex);
    }
    ~__mutex()
    {
      if (__gthread_active_p())
 __gthread_mutex_destroy(&_M_mutex);
    }
    void lock()
    {
      if (__gthread_active_p())
 {
   if (__gthread_mutex_lock(&_M_mutex) != 0)
     __throw_concurrence_lock_error();
 }
    }
    void unlock()
    {
      if (__gthread_active_p())
 {
   if (__gthread_mutex_unlock(&_M_mutex) != 0)
     __throw_concurrence_unlock_error();
 }
    }
    __gthread_mutex_t* gthread_mutex(void)
      { return &_M_mutex; }
  };
  class __recursive_mutex
  {
  private:
    __gthread_recursive_mutex_t _M_mutex = (pthread_mutex_t)((void *) (size_t) -3);
    __recursive_mutex(const __recursive_mutex&);
    __recursive_mutex& operator=(const __recursive_mutex&);
  public:
    __recursive_mutex()
    {
    }
    void lock()
    {
      if (__gthread_active_p())
 {
   if (__gthread_recursive_mutex_lock(&_M_mutex) != 0)
     __throw_concurrence_lock_error();
 }
    }
    void unlock()
    {
      if (__gthread_active_p())
 {
   if (__gthread_recursive_mutex_unlock(&_M_mutex) != 0)
     __throw_concurrence_unlock_error();
 }
    }
    __gthread_recursive_mutex_t* gthread_recursive_mutex(void)
    { return &_M_mutex; }
  };
  class __scoped_lock
  {
  public:
    typedef __mutex __mutex_type;
  private:
    __mutex_type& _M_device;
    __scoped_lock(const __scoped_lock&);
    __scoped_lock& operator=(const __scoped_lock&);
  public:
    explicit __scoped_lock(__mutex_type& __name) : _M_device(__name)
    { _M_device.lock(); }
    ~__scoped_lock() throw()
    { _M_device.unlock(); }
  };
  class __cond
  {
  private:
    __gthread_cond_t _M_cond = (pthread_cond_t)((void *) (size_t) -1);
    __cond(const __cond&);
    __cond& operator=(const __cond&);
  public:
    __cond()
    {
    }
    void broadcast()
    {
      if (__gthread_active_p())
 {
   if (__gthread_cond_broadcast(&_M_cond) != 0)
     __throw_concurrence_broadcast_error();
 }
    }
    void wait(__mutex *mutex)
    {
      {
   if (__gthread_cond_wait(&_M_cond, mutex->gthread_mutex()) != 0)
     __throw_concurrence_wait_error();
      }
    }
    void wait_recursive(__recursive_mutex *mutex)
    {
      {
   if (__gthread_cond_wait_recursive(&_M_cond,
         mutex->gthread_recursive_mutex())
       != 0)
     __throw_concurrence_wait_error();
      }
    }
  };

}
namespace std
{

  template<typename _Arg, typename _Result>
    struct unary_function
    {
      typedef _Arg argument_type;
      typedef _Result result_type;
    };
  template<typename _Arg1, typename _Arg2, typename _Result>
    struct binary_function
    {
      typedef _Arg1 first_argument_type;
      typedef _Arg2 second_argument_type;
      typedef _Result result_type;
    };
  struct __is_transparent;
  template<typename _Tp = void>
    struct plus;
  template<typename _Tp = void>
    struct minus;
  template<typename _Tp = void>
    struct multiplies;
  template<typename _Tp = void>
    struct divides;
  template<typename _Tp = void>
    struct modulus;
  template<typename _Tp = void>
    struct negate;
  template<typename _Tp>
    struct plus : public binary_function<_Tp, _Tp, _Tp>
    {
      constexpr
      _Tp
      operator()(const _Tp& __x, const _Tp& __y) const
      { return __x + __y; }
    };
  template<typename _Tp>
    struct minus : public binary_function<_Tp, _Tp, _Tp>
    {
      constexpr
      _Tp
      operator()(const _Tp& __x, const _Tp& __y) const
      { return __x - __y; }
    };
  template<typename _Tp>
    struct multiplies : public binary_function<_Tp, _Tp, _Tp>
    {
      constexpr
      _Tp
      operator()(const _Tp& __x, const _Tp& __y) const
      { return __x * __y; }
    };
  template<typename _Tp>
    struct divides : public binary_function<_Tp, _Tp, _Tp>
    {
      constexpr
      _Tp
      operator()(const _Tp& __x, const _Tp& __y) const
      { return __x / __y; }
    };
  template<typename _Tp>
    struct modulus : public binary_function<_Tp, _Tp, _Tp>
    {
      constexpr
      _Tp
      operator()(const _Tp& __x, const _Tp& __y) const
      { return __x % __y; }
    };
  template<typename _Tp>
    struct negate : public unary_function<_Tp, _Tp>
    {
      constexpr
      _Tp
      operator()(const _Tp& __x) const
      { return -__x; }
    };
  template<>
    struct plus<void>
    {
      template <typename _Tp, typename _Up>
 constexpr
 auto
 operator()(_Tp&& __t, _Up&& __u) const
 noexcept(noexcept(std::forward<_Tp>(__t) + std::forward<_Up>(__u)))
 -> decltype(std::forward<_Tp>(__t) + std::forward<_Up>(__u))
 { return std::forward<_Tp>(__t) + std::forward<_Up>(__u); }
      typedef __is_transparent is_transparent;
    };
  template<>
    struct minus<void>
    {
      template <typename _Tp, typename _Up>
 constexpr
 auto
 operator()(_Tp&& __t, _Up&& __u) const
 noexcept(noexcept(std::forward<_Tp>(__t) - std::forward<_Up>(__u)))
 -> decltype(std::forward<_Tp>(__t) - std::forward<_Up>(__u))
 { return std::forward<_Tp>(__t) - std::forward<_Up>(__u); }
      typedef __is_transparent is_transparent;
    };
  template<>
    struct multiplies<void>
    {
      template <typename _Tp, typename _Up>
 constexpr
 auto
 operator()(_Tp&& __t, _Up&& __u) const
 noexcept(noexcept(std::forward<_Tp>(__t) * std::forward<_Up>(__u)))
 -> decltype(std::forward<_Tp>(__t) * std::forward<_Up>(__u))
 { return std::forward<_Tp>(__t) * std::forward<_Up>(__u); }
      typedef __is_transparent is_transparent;
    };
  template<>
    struct divides<void>
    {
      template <typename _Tp, typename _Up>
 constexpr
 auto
 operator()(_Tp&& __t, _Up&& __u) const
 noexcept(noexcept(std::forward<_Tp>(__t) / std::forward<_Up>(__u)))
 -> decltype(std::forward<_Tp>(__t) / std::forward<_Up>(__u))
 { return std::forward<_Tp>(__t) / std::forward<_Up>(__u); }
      typedef __is_transparent is_transparent;
    };
  template<>
    struct modulus<void>
    {
      template <typename _Tp, typename _Up>
 constexpr
 auto
 operator()(_Tp&& __t, _Up&& __u) const
 noexcept(noexcept(std::forward<_Tp>(__t) % std::forward<_Up>(__u)))
 -> decltype(std::forward<_Tp>(__t) % std::forward<_Up>(__u))
 { return std::forward<_Tp>(__t) % std::forward<_Up>(__u); }
      typedef __is_transparent is_transparent;
    };
  template<>
    struct negate<void>
    {
      template <typename _Tp>
 constexpr
 auto
 operator()(_Tp&& __t) const
 noexcept(noexcept(-std::forward<_Tp>(__t)))
 -> decltype(-std::forward<_Tp>(__t))
 { return -std::forward<_Tp>(__t); }
      typedef __is_transparent is_transparent;
    };
  template<typename _Tp = void>
    struct equal_to;
  template<typename _Tp = void>
    struct not_equal_to;
  template<typename _Tp = void>
    struct greater;
  template<typename _Tp = void>
    struct less;
  template<typename _Tp = void>
    struct greater_equal;
  template<typename _Tp = void>
    struct less_equal;
  template<typename _Tp>
    struct equal_to : public binary_function<_Tp, _Tp, bool>
    {
      constexpr
      bool
      operator()(const _Tp& __x, const _Tp& __y) const
      { return __x == __y; }
    };
  template<typename _Tp>
    struct not_equal_to : public binary_function<_Tp, _Tp, bool>
    {
      constexpr
      bool
      operator()(const _Tp& __x, const _Tp& __y) const
      { return __x != __y; }
    };
  template<typename _Tp>
    struct greater : public binary_function<_Tp, _Tp, bool>
    {
      constexpr
      bool
      operator()(const _Tp& __x, const _Tp& __y) const
      { return __x > __y; }
    };
  template<typename _Tp>
    struct less : public binary_function<_Tp, _Tp, bool>
    {
      constexpr
      bool
      operator()(const _Tp& __x, const _Tp& __y) const
      { return __x < __y; }
    };
  template<typename _Tp>
    struct greater_equal : public binary_function<_Tp, _Tp, bool>
    {
      constexpr
      bool
      operator()(const _Tp& __x, const _Tp& __y) const
      { return __x >= __y; }
    };
  template<typename _Tp>
    struct less_equal : public binary_function<_Tp, _Tp, bool>
    {
      constexpr
      bool
      operator()(const _Tp& __x, const _Tp& __y) const
      { return __x <= __y; }
    };
  template<typename _Tp>
    struct greater<_Tp*> : public binary_function<_Tp*, _Tp*, bool>
    {
      constexpr bool
      operator()(_Tp* __x, _Tp* __y) const noexcept
      {
 if (__builtin_constant_p (__x > __y))
   return __x > __y;
 return (long long unsigned int)__x > (long long unsigned int)__y;
      }
    };
  template<typename _Tp>
    struct less<_Tp*> : public binary_function<_Tp*, _Tp*, bool>
    {
      constexpr bool
      operator()(_Tp* __x, _Tp* __y) const noexcept
      {
 if (__builtin_constant_p (__x < __y))
   return __x < __y;
 return (long long unsigned int)__x < (long long unsigned int)__y;
      }
    };
  template<typename _Tp>
    struct greater_equal<_Tp*> : public binary_function<_Tp*, _Tp*, bool>
    {
      constexpr bool
      operator()(_Tp* __x, _Tp* __y) const noexcept
      {
 if (__builtin_constant_p (__x >= __y))
   return __x >= __y;
 return (long long unsigned int)__x >= (long long unsigned int)__y;
      }
    };
  template<typename _Tp>
    struct less_equal<_Tp*> : public binary_function<_Tp*, _Tp*, bool>
    {
      constexpr bool
      operator()(_Tp* __x, _Tp* __y) const noexcept
      {
 if (__builtin_constant_p (__x <= __y))
   return __x <= __y;
 return (long long unsigned int)__x <= (long long unsigned int)__y;
      }
    };
  template<>
    struct equal_to<void>
    {
      template <typename _Tp, typename _Up>
 constexpr auto
 operator()(_Tp&& __t, _Up&& __u) const
 noexcept(noexcept(std::forward<_Tp>(__t) == std::forward<_Up>(__u)))
 -> decltype(std::forward<_Tp>(__t) == std::forward<_Up>(__u))
 { return std::forward<_Tp>(__t) == std::forward<_Up>(__u); }
      typedef __is_transparent is_transparent;
    };
  template<>
    struct not_equal_to<void>
    {
      template <typename _Tp, typename _Up>
 constexpr auto
 operator()(_Tp&& __t, _Up&& __u) const
 noexcept(noexcept(std::forward<_Tp>(__t) != std::forward<_Up>(__u)))
 -> decltype(std::forward<_Tp>(__t) != std::forward<_Up>(__u))
 { return std::forward<_Tp>(__t) != std::forward<_Up>(__u); }
      typedef __is_transparent is_transparent;
    };
  template<>
    struct greater<void>
    {
      template <typename _Tp, typename _Up>
 constexpr auto
 operator()(_Tp&& __t, _Up&& __u) const
 noexcept(noexcept(std::forward<_Tp>(__t) > std::forward<_Up>(__u)))
 -> decltype(std::forward<_Tp>(__t) > std::forward<_Up>(__u))
 {
   return _S_cmp(std::forward<_Tp>(__t), std::forward<_Up>(__u),
   __ptr_cmp<_Tp, _Up>{});
 }
      template<typename _Tp, typename _Up>
 constexpr bool
 operator()(_Tp* __t, _Up* __u) const noexcept
 { return greater<common_type_t<_Tp*, _Up*>>{}(__t, __u); }
      typedef __is_transparent is_transparent;
    private:
      template <typename _Tp, typename _Up>
 static constexpr decltype(auto)
 _S_cmp(_Tp&& __t, _Up&& __u, false_type)
 { return std::forward<_Tp>(__t) > std::forward<_Up>(__u); }
      template <typename _Tp, typename _Up>
 static constexpr bool
 _S_cmp(_Tp&& __t, _Up&& __u, true_type) noexcept
 {
   return greater<const volatile void*>{}(
       static_cast<const volatile void*>(std::forward<_Tp>(__t)),
       static_cast<const volatile void*>(std::forward<_Up>(__u)));
 }
      template<typename _Tp, typename _Up, typename = void>
 struct __not_overloaded2 : true_type { };
      template<typename _Tp, typename _Up>
 struct __not_overloaded2<_Tp, _Up, __void_t<
   decltype(std::declval<_Tp>().operator>(std::declval<_Up>()))>>
 : false_type { };
      template<typename _Tp, typename _Up, typename = void>
 struct __not_overloaded : __not_overloaded2<_Tp, _Up> { };
      template<typename _Tp, typename _Up>
 struct __not_overloaded<_Tp, _Up, __void_t<
   decltype(operator>(std::declval<_Tp>(), std::declval<_Up>()))>>
 : false_type { };
      template<typename _Tp, typename _Up>
 using __ptr_cmp = __and_<__not_overloaded<_Tp, _Up>,
       is_convertible<_Tp, const volatile void*>,
       is_convertible<_Up, const volatile void*>>;
    };
  template<>
    struct less<void>
    {
      template <typename _Tp, typename _Up>
 constexpr auto
 operator()(_Tp&& __t, _Up&& __u) const
 noexcept(noexcept(std::forward<_Tp>(__t) < std::forward<_Up>(__u)))
 -> decltype(std::forward<_Tp>(__t) < std::forward<_Up>(__u))
 {
   return _S_cmp(std::forward<_Tp>(__t), std::forward<_Up>(__u),
   __ptr_cmp<_Tp, _Up>{});
 }
      template<typename _Tp, typename _Up>
 constexpr bool
 operator()(_Tp* __t, _Up* __u) const noexcept
 { return less<common_type_t<_Tp*, _Up*>>{}(__t, __u); }
      typedef __is_transparent is_transparent;
    private:
      template <typename _Tp, typename _Up>
 static constexpr decltype(auto)
 _S_cmp(_Tp&& __t, _Up&& __u, false_type)
 { return std::forward<_Tp>(__t) < std::forward<_Up>(__u); }
      template <typename _Tp, typename _Up>
 static constexpr bool
 _S_cmp(_Tp&& __t, _Up&& __u, true_type) noexcept
 {
   return less<const volatile void*>{}(
       static_cast<const volatile void*>(std::forward<_Tp>(__t)),
       static_cast<const volatile void*>(std::forward<_Up>(__u)));
 }
      template<typename _Tp, typename _Up, typename = void>
 struct __not_overloaded2 : true_type { };
      template<typename _Tp, typename _Up>
 struct __not_overloaded2<_Tp, _Up, __void_t<
   decltype(std::declval<_Tp>().operator<(std::declval<_Up>()))>>
 : false_type { };
      template<typename _Tp, typename _Up, typename = void>
 struct __not_overloaded : __not_overloaded2<_Tp, _Up> { };
      template<typename _Tp, typename _Up>
 struct __not_overloaded<_Tp, _Up, __void_t<
   decltype(operator<(std::declval<_Tp>(), std::declval<_Up>()))>>
 : false_type { };
      template<typename _Tp, typename _Up>
 using __ptr_cmp = __and_<__not_overloaded<_Tp, _Up>,
       is_convertible<_Tp, const volatile void*>,
       is_convertible<_Up, const volatile void*>>;
    };
  template<>
    struct greater_equal<void>
    {
      template <typename _Tp, typename _Up>
 constexpr auto
 operator()(_Tp&& __t, _Up&& __u) const
 noexcept(noexcept(std::forward<_Tp>(__t) >= std::forward<_Up>(__u)))
 -> decltype(std::forward<_Tp>(__t) >= std::forward<_Up>(__u))
 {
   return _S_cmp(std::forward<_Tp>(__t), std::forward<_Up>(__u),
   __ptr_cmp<_Tp, _Up>{});
 }
      template<typename _Tp, typename _Up>
 constexpr bool
 operator()(_Tp* __t, _Up* __u) const noexcept
 { return greater_equal<common_type_t<_Tp*, _Up*>>{}(__t, __u); }
      typedef __is_transparent is_transparent;
    private:
      template <typename _Tp, typename _Up>
 static constexpr decltype(auto)
 _S_cmp(_Tp&& __t, _Up&& __u, false_type)
 { return std::forward<_Tp>(__t) >= std::forward<_Up>(__u); }
      template <typename _Tp, typename _Up>
 static constexpr bool
 _S_cmp(_Tp&& __t, _Up&& __u, true_type) noexcept
 {
   return greater_equal<const volatile void*>{}(
       static_cast<const volatile void*>(std::forward<_Tp>(__t)),
       static_cast<const volatile void*>(std::forward<_Up>(__u)));
 }
      template<typename _Tp, typename _Up, typename = void>
 struct __not_overloaded2 : true_type { };
      template<typename _Tp, typename _Up>
 struct __not_overloaded2<_Tp, _Up, __void_t<
   decltype(std::declval<_Tp>().operator>=(std::declval<_Up>()))>>
 : false_type { };
      template<typename _Tp, typename _Up, typename = void>
 struct __not_overloaded : __not_overloaded2<_Tp, _Up> { };
      template<typename _Tp, typename _Up>
 struct __not_overloaded<_Tp, _Up, __void_t<
   decltype(operator>=(std::declval<_Tp>(), std::declval<_Up>()))>>
 : false_type { };
      template<typename _Tp, typename _Up>
 using __ptr_cmp = __and_<__not_overloaded<_Tp, _Up>,
       is_convertible<_Tp, const volatile void*>,
       is_convertible<_Up, const volatile void*>>;
    };
  template<>
    struct less_equal<void>
    {
      template <typename _Tp, typename _Up>
 constexpr auto
 operator()(_Tp&& __t, _Up&& __u) const
 noexcept(noexcept(std::forward<_Tp>(__t) <= std::forward<_Up>(__u)))
 -> decltype(std::forward<_Tp>(__t) <= std::forward<_Up>(__u))
 {
   return _S_cmp(std::forward<_Tp>(__t), std::forward<_Up>(__u),
   __ptr_cmp<_Tp, _Up>{});
 }
      template<typename _Tp, typename _Up>
 constexpr bool
 operator()(_Tp* __t, _Up* __u) const noexcept
 { return less_equal<common_type_t<_Tp*, _Up*>>{}(__t, __u); }
      typedef __is_transparent is_transparent;
    private:
      template <typename _Tp, typename _Up>
 static constexpr decltype(auto)
 _S_cmp(_Tp&& __t, _Up&& __u, false_type)
 { return std::forward<_Tp>(__t) <= std::forward<_Up>(__u); }
      template <typename _Tp, typename _Up>
 static constexpr bool
 _S_cmp(_Tp&& __t, _Up&& __u, true_type) noexcept
 {
   return less_equal<const volatile void*>{}(
       static_cast<const volatile void*>(std::forward<_Tp>(__t)),
       static_cast<const volatile void*>(std::forward<_Up>(__u)));
 }
      template<typename _Tp, typename _Up, typename = void>
 struct __not_overloaded2 : true_type { };
      template<typename _Tp, typename _Up>
 struct __not_overloaded2<_Tp, _Up, __void_t<
   decltype(std::declval<_Tp>().operator<=(std::declval<_Up>()))>>
 : false_type { };
      template<typename _Tp, typename _Up, typename = void>
 struct __not_overloaded : __not_overloaded2<_Tp, _Up> { };
      template<typename _Tp, typename _Up>
 struct __not_overloaded<_Tp, _Up, __void_t<
   decltype(operator<=(std::declval<_Tp>(), std::declval<_Up>()))>>
 : false_type { };
      template<typename _Tp, typename _Up>
 using __ptr_cmp = __and_<__not_overloaded<_Tp, _Up>,
       is_convertible<_Tp, const volatile void*>,
       is_convertible<_Up, const volatile void*>>;
    };
  template<typename _Tp = void>
    struct logical_and;
  template<typename _Tp = void>
    struct logical_or;
  template<typename _Tp = void>
    struct logical_not;
  template<typename _Tp>
    struct logical_and : public binary_function<_Tp, _Tp, bool>
    {
      constexpr
      bool
      operator()(const _Tp& __x, const _Tp& __y) const
      { return __x && __y; }
    };
  template<typename _Tp>
    struct logical_or : public binary_function<_Tp, _Tp, bool>
    {
      constexpr
      bool
      operator()(const _Tp& __x, const _Tp& __y) const
      { return __x || __y; }
    };
  template<typename _Tp>
    struct logical_not : public unary_function<_Tp, bool>
    {
      constexpr
      bool
      operator()(const _Tp& __x) const
      { return !__x; }
    };
  template<>
    struct logical_and<void>
    {
      template <typename _Tp, typename _Up>
 constexpr
 auto
 operator()(_Tp&& __t, _Up&& __u) const
 noexcept(noexcept(std::forward<_Tp>(__t) && std::forward<_Up>(__u)))
 -> decltype(std::forward<_Tp>(__t) && std::forward<_Up>(__u))
 { return std::forward<_Tp>(__t) && std::forward<_Up>(__u); }
      typedef __is_transparent is_transparent;
    };
  template<>
    struct logical_or<void>
    {
      template <typename _Tp, typename _Up>
 constexpr
 auto
 operator()(_Tp&& __t, _Up&& __u) const
 noexcept(noexcept(std::forward<_Tp>(__t) || std::forward<_Up>(__u)))
 -> decltype(std::forward<_Tp>(__t) || std::forward<_Up>(__u))
 { return std::forward<_Tp>(__t) || std::forward<_Up>(__u); }
      typedef __is_transparent is_transparent;
    };
  template<>
    struct logical_not<void>
    {
      template <typename _Tp>
 constexpr
 auto
 operator()(_Tp&& __t) const
 noexcept(noexcept(!std::forward<_Tp>(__t)))
 -> decltype(!std::forward<_Tp>(__t))
 { return !std::forward<_Tp>(__t); }
      typedef __is_transparent is_transparent;
    };
  template<typename _Tp = void>
    struct bit_and;
  template<typename _Tp = void>
    struct bit_or;
  template<typename _Tp = void>
    struct bit_xor;
  template<typename _Tp = void>
    struct bit_not;
  template<typename _Tp>
    struct bit_and : public binary_function<_Tp, _Tp, _Tp>
    {
      constexpr
      _Tp
      operator()(const _Tp& __x, const _Tp& __y) const
      { return __x & __y; }
    };
  template<typename _Tp>
    struct bit_or : public binary_function<_Tp, _Tp, _Tp>
    {
      constexpr
      _Tp
      operator()(const _Tp& __x, const _Tp& __y) const
      { return __x | __y; }
    };
  template<typename _Tp>
    struct bit_xor : public binary_function<_Tp, _Tp, _Tp>
    {
      constexpr
      _Tp
      operator()(const _Tp& __x, const _Tp& __y) const
      { return __x ^ __y; }
    };
  template<typename _Tp>
    struct bit_not : public unary_function<_Tp, _Tp>
    {
    constexpr
      _Tp
      operator()(const _Tp& __x) const
      { return ~__x; }
    };
  template <>
    struct bit_and<void>
    {
      template <typename _Tp, typename _Up>
 constexpr
 auto
 operator()(_Tp&& __t, _Up&& __u) const
 noexcept(noexcept(std::forward<_Tp>(__t) & std::forward<_Up>(__u)))
 -> decltype(std::forward<_Tp>(__t) & std::forward<_Up>(__u))
 { return std::forward<_Tp>(__t) & std::forward<_Up>(__u); }
      typedef __is_transparent is_transparent;
    };
  template <>
    struct bit_or<void>
    {
      template <typename _Tp, typename _Up>
 constexpr
 auto
 operator()(_Tp&& __t, _Up&& __u) const
 noexcept(noexcept(std::forward<_Tp>(__t) | std::forward<_Up>(__u)))
 -> decltype(std::forward<_Tp>(__t) | std::forward<_Up>(__u))
 { return std::forward<_Tp>(__t) | std::forward<_Up>(__u); }
      typedef __is_transparent is_transparent;
    };
  template <>
    struct bit_xor<void>
    {
      template <typename _Tp, typename _Up>
 constexpr
 auto
 operator()(_Tp&& __t, _Up&& __u) const
 noexcept(noexcept(std::forward<_Tp>(__t) ^ std::forward<_Up>(__u)))
 -> decltype(std::forward<_Tp>(__t) ^ std::forward<_Up>(__u))
 { return std::forward<_Tp>(__t) ^ std::forward<_Up>(__u); }
      typedef __is_transparent is_transparent;
    };
  template <>
    struct bit_not<void>
    {
      template <typename _Tp>
 constexpr
 auto
 operator()(_Tp&& __t) const
 noexcept(noexcept(~std::forward<_Tp>(__t)))
 -> decltype(~std::forward<_Tp>(__t))
 { return ~std::forward<_Tp>(__t); }
      typedef __is_transparent is_transparent;
    };
  template<typename _Predicate>
    class unary_negate
    : public unary_function<typename _Predicate::argument_type, bool>
    {
    protected:
      _Predicate _M_pred;
    public:
      constexpr
      explicit
      unary_negate(const _Predicate& __x) : _M_pred(__x) { }
      constexpr
      bool
      operator()(const typename _Predicate::argument_type& __x) const
      { return !_M_pred(__x); }
    };
  template<typename _Predicate>
    constexpr
    inline unary_negate<_Predicate>
    not1(const _Predicate& __pred)
    { return unary_negate<_Predicate>(__pred); }
  template<typename _Predicate>
    class binary_negate
    : public binary_function<typename _Predicate::first_argument_type,
        typename _Predicate::second_argument_type, bool>
    {
    protected:
      _Predicate _M_pred;
    public:
      constexpr
      explicit
      binary_negate(const _Predicate& __x) : _M_pred(__x) { }
      constexpr
      bool
      operator()(const typename _Predicate::first_argument_type& __x,
   const typename _Predicate::second_argument_type& __y) const
      { return !_M_pred(__x, __y); }
    };
  template<typename _Predicate>
    constexpr
    inline binary_negate<_Predicate>
    not2(const _Predicate& __pred)
    { return binary_negate<_Predicate>(__pred); }
  template<typename _Arg, typename _Result>
    class pointer_to_unary_function : public unary_function<_Arg, _Result>
    {
    protected:
      _Result (*_M_ptr)(_Arg);
    public:
      pointer_to_unary_function() { }
      explicit
      pointer_to_unary_function(_Result (*__x)(_Arg))
      : _M_ptr(__x) { }
      _Result
      operator()(_Arg __x) const
      { return _M_ptr(__x); }
    };
  template<typename _Arg, typename _Result>
    inline pointer_to_unary_function<_Arg, _Result>
    ptr_fun(_Result (*__x)(_Arg))
    { return pointer_to_unary_function<_Arg, _Result>(__x); }
  template<typename _Arg1, typename _Arg2, typename _Result>
    class pointer_to_binary_function
    : public binary_function<_Arg1, _Arg2, _Result>
    {
    protected:
      _Result (*_M_ptr)(_Arg1, _Arg2);
    public:
      pointer_to_binary_function() { }
      explicit
      pointer_to_binary_function(_Result (*__x)(_Arg1, _Arg2))
      : _M_ptr(__x) { }
      _Result
      operator()(_Arg1 __x, _Arg2 __y) const
      { return _M_ptr(__x, __y); }
    };
  template<typename _Arg1, typename _Arg2, typename _Result>
    inline pointer_to_binary_function<_Arg1, _Arg2, _Result>
    ptr_fun(_Result (*__x)(_Arg1, _Arg2))
    { return pointer_to_binary_function<_Arg1, _Arg2, _Result>(__x); }
  template<typename _Tp>
    struct _Identity
    : public unary_function<_Tp, _Tp>
    {
      _Tp&
      operator()(_Tp& __x) const
      { return __x; }
      const _Tp&
      operator()(const _Tp& __x) const
      { return __x; }
    };
  template<typename _Tp> struct _Identity<const _Tp> : _Identity<_Tp> { };
  template<typename _Pair>
    struct _Select1st
    : public unary_function<_Pair, typename _Pair::first_type>
    {
      typename _Pair::first_type&
      operator()(_Pair& __x) const
      { return __x.first; }
      const typename _Pair::first_type&
      operator()(const _Pair& __x) const
      { return __x.first; }
      template<typename _Pair2>
        typename _Pair2::first_type&
        operator()(_Pair2& __x) const
        { return __x.first; }
      template<typename _Pair2>
        const typename _Pair2::first_type&
        operator()(const _Pair2& __x) const
        { return __x.first; }
    };
  template<typename _Pair>
    struct _Select2nd
    : public unary_function<_Pair, typename _Pair::second_type>
    {
      typename _Pair::second_type&
      operator()(_Pair& __x) const
      { return __x.second; }
      const typename _Pair::second_type&
      operator()(const _Pair& __x) const
      { return __x.second; }
    };
  template<typename _Ret, typename _Tp>
    class mem_fun_t : public unary_function<_Tp*, _Ret>
    {
    public:
      explicit
      mem_fun_t(_Ret (_Tp::*__pf)())
      : _M_f(__pf) { }
      _Ret
      operator()(_Tp* __p) const
      { return (__p->*_M_f)(); }
    private:
      _Ret (_Tp::*_M_f)();
    };
  template<typename _Ret, typename _Tp>
    class const_mem_fun_t : public unary_function<const _Tp*, _Ret>
    {
    public:
      explicit
      const_mem_fun_t(_Ret (_Tp::*__pf)() const)
      : _M_f(__pf) { }
      _Ret
      operator()(const _Tp* __p) const
      { return (__p->*_M_f)(); }
    private:
      _Ret (_Tp::*_M_f)() const;
    };
  template<typename _Ret, typename _Tp>
    class mem_fun_ref_t : public unary_function<_Tp, _Ret>
    {
    public:
      explicit
      mem_fun_ref_t(_Ret (_Tp::*__pf)())
      : _M_f(__pf) { }
      _Ret
      operator()(_Tp& __r) const
      { return (__r.*_M_f)(); }
    private:
      _Ret (_Tp::*_M_f)();
  };
  template<typename _Ret, typename _Tp>
    class const_mem_fun_ref_t : public unary_function<_Tp, _Ret>
    {
    public:
      explicit
      const_mem_fun_ref_t(_Ret (_Tp::*__pf)() const)
      : _M_f(__pf) { }
      _Ret
      operator()(const _Tp& __r) const
      { return (__r.*_M_f)(); }
    private:
      _Ret (_Tp::*_M_f)() const;
    };
  template<typename _Ret, typename _Tp, typename _Arg>
    class mem_fun1_t : public binary_function<_Tp*, _Arg, _Ret>
    {
    public:
      explicit
      mem_fun1_t(_Ret (_Tp::*__pf)(_Arg))
      : _M_f(__pf) { }
      _Ret
      operator()(_Tp* __p, _Arg __x) const
      { return (__p->*_M_f)(__x); }
    private:
      _Ret (_Tp::*_M_f)(_Arg);
    };
  template<typename _Ret, typename _Tp, typename _Arg>
    class const_mem_fun1_t : public binary_function<const _Tp*, _Arg, _Ret>
    {
    public:
      explicit
      const_mem_fun1_t(_Ret (_Tp::*__pf)(_Arg) const)
      : _M_f(__pf) { }
      _Ret
      operator()(const _Tp* __p, _Arg __x) const
      { return (__p->*_M_f)(__x); }
    private:
      _Ret (_Tp::*_M_f)(_Arg) const;
    };
  template<typename _Ret, typename _Tp, typename _Arg>
    class mem_fun1_ref_t : public binary_function<_Tp, _Arg, _Ret>
    {
    public:
      explicit
      mem_fun1_ref_t(_Ret (_Tp::*__pf)(_Arg))
      : _M_f(__pf) { }
      _Ret
      operator()(_Tp& __r, _Arg __x) const
      { return (__r.*_M_f)(__x); }
    private:
      _Ret (_Tp::*_M_f)(_Arg);
    };
  template<typename _Ret, typename _Tp, typename _Arg>
    class const_mem_fun1_ref_t : public binary_function<_Tp, _Arg, _Ret>
    {
    public:
      explicit
      const_mem_fun1_ref_t(_Ret (_Tp::*__pf)(_Arg) const)
      : _M_f(__pf) { }
      _Ret
      operator()(const _Tp& __r, _Arg __x) const
      { return (__r.*_M_f)(__x); }
    private:
      _Ret (_Tp::*_M_f)(_Arg) const;
    };
  template<typename _Ret, typename _Tp>
    inline mem_fun_t<_Ret, _Tp>
    mem_fun(_Ret (_Tp::*__f)())
    { return mem_fun_t<_Ret, _Tp>(__f); }
  template<typename _Ret, typename _Tp>
    inline const_mem_fun_t<_Ret, _Tp>
    mem_fun(_Ret (_Tp::*__f)() const)
    { return const_mem_fun_t<_Ret, _Tp>(__f); }
  template<typename _Ret, typename _Tp>
    inline mem_fun_ref_t<_Ret, _Tp>
    mem_fun_ref(_Ret (_Tp::*__f)())
    { return mem_fun_ref_t<_Ret, _Tp>(__f); }
  template<typename _Ret, typename _Tp>
    inline const_mem_fun_ref_t<_Ret, _Tp>
    mem_fun_ref(_Ret (_Tp::*__f)() const)
    { return const_mem_fun_ref_t<_Ret, _Tp>(__f); }
  template<typename _Ret, typename _Tp, typename _Arg>
    inline mem_fun1_t<_Ret, _Tp, _Arg>
    mem_fun(_Ret (_Tp::*__f)(_Arg))
    { return mem_fun1_t<_Ret, _Tp, _Arg>(__f); }
  template<typename _Ret, typename _Tp, typename _Arg>
    inline const_mem_fun1_t<_Ret, _Tp, _Arg>
    mem_fun(_Ret (_Tp::*__f)(_Arg) const)
    { return const_mem_fun1_t<_Ret, _Tp, _Arg>(__f); }
  template<typename _Ret, typename _Tp, typename _Arg>
    inline mem_fun1_ref_t<_Ret, _Tp, _Arg>
    mem_fun_ref(_Ret (_Tp::*__f)(_Arg))
    { return mem_fun1_ref_t<_Ret, _Tp, _Arg>(__f); }
  template<typename _Ret, typename _Tp, typename _Arg>
    inline const_mem_fun1_ref_t<_Ret, _Tp, _Arg>
    mem_fun_ref(_Ret (_Tp::*__f)(_Arg) const)
    { return const_mem_fun1_ref_t<_Ret, _Tp, _Arg>(__f); }

}
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
namespace std
{

  template<typename _Operation>
    class binder1st
    : public unary_function<typename _Operation::second_argument_type,
       typename _Operation::result_type>
    {
    protected:
      _Operation op;
      typename _Operation::first_argument_type value;
    public:
      binder1st(const _Operation& __x,
  const typename _Operation::first_argument_type& __y)
      : op(__x), value(__y) { }
      typename _Operation::result_type
      operator()(const typename _Operation::second_argument_type& __x) const
      { return op(value, __x); }
      typename _Operation::result_type
      operator()(typename _Operation::second_argument_type& __x) const
      { return op(value, __x); }
    } __attribute__ ((__deprecated__));
  template<typename _Operation, typename _Tp>
    inline binder1st<_Operation>
    bind1st(const _Operation& __fn, const _Tp& __x)
    {
      typedef typename _Operation::first_argument_type _Arg1_type;
      return binder1st<_Operation>(__fn, _Arg1_type(__x));
    }
  template<typename _Operation>
    class binder2nd
    : public unary_function<typename _Operation::first_argument_type,
       typename _Operation::result_type>
    {
    protected:
      _Operation op;
      typename _Operation::second_argument_type value;
    public:
      binder2nd(const _Operation& __x,
  const typename _Operation::second_argument_type& __y)
      : op(__x), value(__y) { }
      typename _Operation::result_type
      operator()(const typename _Operation::first_argument_type& __x) const
      { return op(__x, value); }
      typename _Operation::result_type
      operator()(typename _Operation::first_argument_type& __x) const
      { return op(__x, value); }
    } __attribute__ ((__deprecated__));
  template<typename _Operation, typename _Tp>
    inline binder2nd<_Operation>
    bind2nd(const _Operation& __fn, const _Tp& __x)
    {
      typedef typename _Operation::second_argument_type _Arg2_type;
      return binder2nd<_Operation>(__fn, _Arg2_type(__x));
    }

}
#pragma GCC diagnostic pop
namespace std
{

  struct __erased_type { };
  template<typename _Alloc, typename _Tp>
    using __is_erased_or_convertible
      = __or_<is_same<_Tp, __erased_type>, is_convertible<_Alloc, _Tp>>;
  struct allocator_arg_t { explicit allocator_arg_t() = default; };
  constexpr allocator_arg_t allocator_arg =
    allocator_arg_t();
  template<typename _Tp, typename _Alloc, typename = __void_t<>>
    struct __uses_allocator_helper
    : false_type { };
  template<typename _Tp, typename _Alloc>
    struct __uses_allocator_helper<_Tp, _Alloc,
       __void_t<typename _Tp::allocator_type>>
    : __is_erased_or_convertible<_Alloc, typename _Tp::allocator_type>::type
    { };
  template<typename _Tp, typename _Alloc>
    struct uses_allocator
    : __uses_allocator_helper<_Tp, _Alloc>::type
    { };
  struct __uses_alloc_base { };
  struct __uses_alloc0 : __uses_alloc_base
  {
    struct _Sink { void operator=(const void*) { } } _M_a;
  };
  template<typename _Alloc>
    struct __uses_alloc1 : __uses_alloc_base { const _Alloc* _M_a; };
  template<typename _Alloc>
    struct __uses_alloc2 : __uses_alloc_base { const _Alloc* _M_a; };
  template<bool, typename _Tp, typename _Alloc, typename... _Args>
    struct __uses_alloc;
  template<typename _Tp, typename _Alloc, typename... _Args>
    struct __uses_alloc<true, _Tp, _Alloc, _Args...>
    : conditional<
        is_constructible<_Tp, allocator_arg_t, _Alloc, _Args...>::value,
        __uses_alloc1<_Alloc>,
        __uses_alloc2<_Alloc>>::type
    {
      static_assert(__or_<
   is_constructible<_Tp, allocator_arg_t, _Alloc, _Args...>,
   is_constructible<_Tp, _Args..., _Alloc>>::value, "construction with"
   " an allocator must be possible if uses_allocator is true");
    };
  template<typename _Tp, typename _Alloc, typename... _Args>
    struct __uses_alloc<false, _Tp, _Alloc, _Args...>
    : __uses_alloc0 { };
  template<typename _Tp, typename _Alloc, typename... _Args>
    using __uses_alloc_t =
      __uses_alloc<uses_allocator<_Tp, _Alloc>::value, _Tp, _Alloc, _Args...>;
  template<typename _Tp, typename _Alloc, typename... _Args>
    inline __uses_alloc_t<_Tp, _Alloc, _Args...>
    __use_alloc(const _Alloc& __a)
    {
      __uses_alloc_t<_Tp, _Alloc, _Args...> __ret;
      __ret._M_a = std::__addressof(__a);
      return __ret;
    }
  template<typename _Tp, typename _Alloc, typename... _Args>
    void
    __use_alloc(const _Alloc&&) = delete;
  template<template<typename...> class _Predicate,
    typename _Tp, typename _Alloc, typename... _Args>
    struct __is_uses_allocator_predicate
    : conditional<uses_allocator<_Tp, _Alloc>::value,
      __or_<_Predicate<_Tp, allocator_arg_t, _Alloc, _Args...>,
     _Predicate<_Tp, _Args..., _Alloc>>,
      _Predicate<_Tp, _Args...>>::type { };
  template<typename _Tp, typename _Alloc, typename... _Args>
    struct __is_uses_allocator_constructible
    : __is_uses_allocator_predicate<is_constructible, _Tp, _Alloc, _Args...>
    { };
  template<typename _Tp, typename _Alloc, typename... _Args>
    constexpr bool __is_uses_allocator_constructible_v =
      __is_uses_allocator_constructible<_Tp, _Alloc, _Args...>::value;
  template<typename _Tp, typename _Alloc, typename... _Args>
    struct __is_nothrow_uses_allocator_constructible
    : __is_uses_allocator_predicate<is_nothrow_constructible,
        _Tp, _Alloc, _Args...>
    { };
  template<typename _Tp, typename _Alloc, typename... _Args>
    constexpr bool
    __is_nothrow_uses_allocator_constructible_v =
      __is_nothrow_uses_allocator_constructible<_Tp, _Alloc, _Args...>::value;
  template<typename _Tp, typename... _Args>
    void __uses_allocator_construct_impl(__uses_alloc0 __a, _Tp* __ptr,
      _Args&&... __args)
    { ::new ((void*)__ptr) _Tp(std::forward<_Args>(__args)...); }
  template<typename _Tp, typename _Alloc, typename... _Args>
    void __uses_allocator_construct_impl(__uses_alloc1<_Alloc> __a, _Tp* __ptr,
      _Args&&... __args)
    {
      ::new ((void*)__ptr) _Tp(allocator_arg, *__a._M_a,
          std::forward<_Args>(__args)...);
    }
  template<typename _Tp, typename _Alloc, typename... _Args>
    void __uses_allocator_construct_impl(__uses_alloc2<_Alloc> __a, _Tp* __ptr,
      _Args&&... __args)
    { ::new ((void*)__ptr) _Tp(std::forward<_Args>(__args)..., *__a._M_a); }
  template<typename _Tp, typename _Alloc, typename... _Args>
    void __uses_allocator_construct(const _Alloc& __a, _Tp* __ptr,
        _Args&&... __args)
    {
      __uses_allocator_construct_impl(__use_alloc<_Tp, _Alloc, _Args...>(__a),
          __ptr, std::forward<_Args>(__args)...);
    }

}
       
namespace std
{

  namespace rel_ops
  {
    template <class _Tp>
      inline bool
      operator!=(const _Tp& __x, const _Tp& __y)
      { return !(__x == __y); }
    template <class _Tp>
      inline bool
      operator>(const _Tp& __x, const _Tp& __y)
      { return __y < __x; }
    template <class _Tp>
      inline bool
      operator<=(const _Tp& __x, const _Tp& __y)
      { return !(__y < __x); }
    template <class _Tp>
      inline bool
      operator>=(const _Tp& __x, const _Tp& __y)
      { return !(__x < __y); }
  }

}
       
#pragma GCC visibility push(default)
namespace std
{
  template<class _E>
    class initializer_list
    {
    public:
      typedef _E value_type;
      typedef const _E& reference;
      typedef const _E& const_reference;
      typedef size_t size_type;
      typedef const _E* iterator;
      typedef const _E* const_iterator;
    private:
      iterator _M_array;
      size_type _M_len;
      constexpr initializer_list(const_iterator __a, size_type __l)
      : _M_array(__a), _M_len(__l) { }
    public:
      constexpr initializer_list() noexcept
      : _M_array(0), _M_len(0) { }
      constexpr size_type
      size() const noexcept { return _M_len; }
      constexpr const_iterator
      begin() const noexcept { return _M_array; }
      constexpr const_iterator
      end() const noexcept { return begin() + size(); }
    };
  template<class _Tp>
    constexpr const _Tp*
    begin(initializer_list<_Tp> __ils) noexcept
    { return __ils.begin(); }
  template<class _Tp>
    constexpr const _Tp*
    end(initializer_list<_Tp> __ils) noexcept
    { return __ils.end(); }
}
#pragma GCC visibility pop
namespace std
{

  template<typename _Tp>
    struct tuple_size;
  template<typename _Tp,
    typename _Up = typename remove_cv<_Tp>::type,
    typename = typename enable_if<is_same<_Tp, _Up>::value>::type,
    size_t = tuple_size<_Tp>::value>
    using __enable_if_has_tuple_size = _Tp;
  template<typename _Tp>
    struct tuple_size<const __enable_if_has_tuple_size<_Tp>>
    : public tuple_size<_Tp> { };
  template<typename _Tp>
    struct tuple_size<volatile __enable_if_has_tuple_size<_Tp>>
    : public tuple_size<_Tp> { };
  template<typename _Tp>
    struct tuple_size<const volatile __enable_if_has_tuple_size<_Tp>>
    : public tuple_size<_Tp> { };
  template<std::size_t __i, typename _Tp>
    struct tuple_element;
  template<std::size_t __i, typename _Tp>
    using __tuple_element_t = typename tuple_element<__i, _Tp>::type;
  template<std::size_t __i, typename _Tp>
    struct tuple_element<__i, const _Tp>
    {
      typedef typename add_const<__tuple_element_t<__i, _Tp>>::type type;
    };
  template<std::size_t __i, typename _Tp>
    struct tuple_element<__i, volatile _Tp>
    {
      typedef typename add_volatile<__tuple_element_t<__i, _Tp>>::type type;
    };
  template<std::size_t __i, typename _Tp>
    struct tuple_element<__i, const volatile _Tp>
    {
      typedef typename add_cv<__tuple_element_t<__i, _Tp>>::type type;
    };
  template<std::size_t __i, typename _Tp>
    using tuple_element_t = typename tuple_element<__i, _Tp>::type;
  template<typename _T1, typename _T2>
    struct __is_tuple_like_impl<std::pair<_T1, _T2>> : true_type
    { };
  template<class _Tp1, class _Tp2>
    struct tuple_size<std::pair<_Tp1, _Tp2>>
    : public integral_constant<std::size_t, 2> { };
  template<class _Tp1, class _Tp2>
    struct tuple_element<0, std::pair<_Tp1, _Tp2>>
    { typedef _Tp1 type; };
  template<class _Tp1, class _Tp2>
    struct tuple_element<1, std::pair<_Tp1, _Tp2>>
    { typedef _Tp2 type; };
  template<std::size_t _Int>
    struct __pair_get;
  template<>
    struct __pair_get<0>
    {
      template<typename _Tp1, typename _Tp2>
        static constexpr _Tp1&
        __get(std::pair<_Tp1, _Tp2>& __pair) noexcept
        { return __pair.first; }
      template<typename _Tp1, typename _Tp2>
        static constexpr _Tp1&&
        __move_get(std::pair<_Tp1, _Tp2>&& __pair) noexcept
        { return std::forward<_Tp1>(__pair.first); }
      template<typename _Tp1, typename _Tp2>
        static constexpr const _Tp1&
        __const_get(const std::pair<_Tp1, _Tp2>& __pair) noexcept
        { return __pair.first; }
      template<typename _Tp1, typename _Tp2>
        static constexpr const _Tp1&&
        __const_move_get(const std::pair<_Tp1, _Tp2>&& __pair) noexcept
        { return std::forward<const _Tp1>(__pair.first); }
    };
  template<>
    struct __pair_get<1>
    {
      template<typename _Tp1, typename _Tp2>
        static constexpr _Tp2&
        __get(std::pair<_Tp1, _Tp2>& __pair) noexcept
        { return __pair.second; }
      template<typename _Tp1, typename _Tp2>
        static constexpr _Tp2&&
        __move_get(std::pair<_Tp1, _Tp2>&& __pair) noexcept
        { return std::forward<_Tp2>(__pair.second); }
      template<typename _Tp1, typename _Tp2>
        static constexpr const _Tp2&
        __const_get(const std::pair<_Tp1, _Tp2>& __pair) noexcept
        { return __pair.second; }
      template<typename _Tp1, typename _Tp2>
        static constexpr const _Tp2&&
        __const_move_get(const std::pair<_Tp1, _Tp2>&& __pair) noexcept
        { return std::forward<const _Tp2>(__pair.second); }
    };
  template<std::size_t _Int, class _Tp1, class _Tp2>
    constexpr typename tuple_element<_Int, std::pair<_Tp1, _Tp2>>::type&
    get(std::pair<_Tp1, _Tp2>& __in) noexcept
    { return __pair_get<_Int>::__get(__in); }
  template<std::size_t _Int, class _Tp1, class _Tp2>
    constexpr typename tuple_element<_Int, std::pair<_Tp1, _Tp2>>::type&&
    get(std::pair<_Tp1, _Tp2>&& __in) noexcept
    { return __pair_get<_Int>::__move_get(std::move(__in)); }
  template<std::size_t _Int, class _Tp1, class _Tp2>
    constexpr const typename tuple_element<_Int, std::pair<_Tp1, _Tp2>>::type&
    get(const std::pair<_Tp1, _Tp2>& __in) noexcept
    { return __pair_get<_Int>::__const_get(__in); }
  template<std::size_t _Int, class _Tp1, class _Tp2>
    constexpr const typename tuple_element<_Int, std::pair<_Tp1, _Tp2>>::type&&
    get(const std::pair<_Tp1, _Tp2>&& __in) noexcept
    { return __pair_get<_Int>::__const_move_get(std::move(__in)); }
  template <typename _Tp, typename _Up>
    constexpr _Tp&
    get(pair<_Tp, _Up>& __p) noexcept
    { return __p.first; }
  template <typename _Tp, typename _Up>
    constexpr const _Tp&
    get(const pair<_Tp, _Up>& __p) noexcept
    { return __p.first; }
  template <typename _Tp, typename _Up>
    constexpr _Tp&&
    get(pair<_Tp, _Up>&& __p) noexcept
    { return std::move(__p.first); }
  template <typename _Tp, typename _Up>
    constexpr const _Tp&&
    get(const pair<_Tp, _Up>&& __p) noexcept
    { return std::move(__p.first); }
  template <typename _Tp, typename _Up>
    constexpr _Tp&
    get(pair<_Up, _Tp>& __p) noexcept
    { return __p.second; }
  template <typename _Tp, typename _Up>
    constexpr const _Tp&
    get(const pair<_Up, _Tp>& __p) noexcept
    { return __p.second; }
  template <typename _Tp, typename _Up>
    constexpr _Tp&&
    get(pair<_Up, _Tp>&& __p) noexcept
    { return std::move(__p.second); }
  template <typename _Tp, typename _Up>
    constexpr const _Tp&&
    get(const pair<_Up, _Tp>&& __p) noexcept
    { return std::move(__p.second); }
  template <typename _Tp, typename _Up = _Tp>
    inline _Tp
    exchange(_Tp& __obj, _Up&& __new_val)
    { return std::__exchange(__obj, std::forward<_Up>(__new_val)); }
  template<size_t... _Indexes> struct _Index_tuple { };
  template<size_t _Num>
    struct _Build_index_tuple
    {
      using __type = _Index_tuple<__integer_pack(_Num)...>;
    };
  template<typename _Tp, _Tp... _Idx>
    struct integer_sequence
    {
      typedef _Tp value_type;
      static constexpr size_t size() noexcept { return sizeof...(_Idx); }
    };
  template<typename _Tp, _Tp _Num>
    using make_integer_sequence
      = integer_sequence<_Tp, __integer_pack(_Num)...>;
  template<size_t... _Idx>
    using index_sequence = integer_sequence<size_t, _Idx...>;
  template<size_t _Num>
    using make_index_sequence = make_integer_sequence<size_t, _Num>;
  template<typename... _Types>
    using index_sequence_for = make_index_sequence<sizeof...(_Types)>;

}
       
       
       
       
       
       
namespace __gnu_cxx
{

  template<typename _CharT>
    struct _Char_types
    {
      typedef unsigned long int_type;
      typedef std::streampos pos_type;
      typedef std::streamoff off_type;
      typedef std::mbstate_t state_type;
    };
  template<typename _CharT>
    struct char_traits
    {
      typedef _CharT char_type;
      typedef typename _Char_types<_CharT>::int_type int_type;
      typedef typename _Char_types<_CharT>::pos_type pos_type;
      typedef typename _Char_types<_CharT>::off_type off_type;
      typedef typename _Char_types<_CharT>::state_type state_type;
      static constexpr void
      assign(char_type& __c1, const char_type& __c2)
      { __c1 = __c2; }
      static constexpr bool
      eq(const char_type& __c1, const char_type& __c2)
      { return __c1 == __c2; }
      static constexpr bool
      lt(const char_type& __c1, const char_type& __c2)
      { return __c1 < __c2; }
      static constexpr int
      compare(const char_type* __s1, const char_type* __s2, std::size_t __n);
      static constexpr std::size_t
      length(const char_type* __s);
      static constexpr const char_type*
      find(const char_type* __s, std::size_t __n, const char_type& __a);
      static char_type*
      move(char_type* __s1, const char_type* __s2, std::size_t __n);
      static char_type*
      copy(char_type* __s1, const char_type* __s2, std::size_t __n);
      static char_type*
      assign(char_type* __s, std::size_t __n, char_type __a);
      static constexpr char_type
      to_char_type(const int_type& __c)
      { return static_cast<char_type>(__c); }
      static constexpr int_type
      to_int_type(const char_type& __c)
      { return static_cast<int_type>(__c); }
      static constexpr bool
      eq_int_type(const int_type& __c1, const int_type& __c2)
      { return __c1 == __c2; }
      static constexpr int_type
      eof()
      { return static_cast<int_type>(-1); }
      static constexpr int_type
      not_eof(const int_type& __c)
      { return !eq_int_type(__c, eof()) ? __c : to_int_type(char_type()); }
    };
  template<typename _CharT>
    constexpr int
    char_traits<_CharT>::
    compare(const char_type* __s1, const char_type* __s2, std::size_t __n)
    {
      for (std::size_t __i = 0; __i < __n; ++__i)
 if (lt(__s1[__i], __s2[__i]))
   return -1;
 else if (lt(__s2[__i], __s1[__i]))
   return 1;
      return 0;
    }
  template<typename _CharT>
    constexpr std::size_t
    char_traits<_CharT>::
    length(const char_type* __p)
    {
      std::size_t __i = 0;
      while (!eq(__p[__i], char_type()))
        ++__i;
      return __i;
    }
  template<typename _CharT>
    constexpr const typename char_traits<_CharT>::char_type*
    char_traits<_CharT>::
    find(const char_type* __s, std::size_t __n, const char_type& __a)
    {
      for (std::size_t __i = 0; __i < __n; ++__i)
        if (eq(__s[__i], __a))
          return __s + __i;
      return 0;
    }
  template<typename _CharT>
    typename char_traits<_CharT>::char_type*
    char_traits<_CharT>::
    move(char_type* __s1, const char_type* __s2, std::size_t __n)
    {
      return static_cast<_CharT*>(__builtin_memmove(__s1, __s2,
          __n * sizeof(char_type)));
    }
  template<typename _CharT>
    typename char_traits<_CharT>::char_type*
    char_traits<_CharT>::
    copy(char_type* __s1, const char_type* __s2, std::size_t __n)
    {
      std::copy(__s2, __s2 + __n, __s1);
      return __s1;
    }
  template<typename _CharT>
    typename char_traits<_CharT>::char_type*
    char_traits<_CharT>::
    assign(char_type* __s, std::size_t __n, char_type __a)
    {
      std::fill_n(__s, __n, __a);
      return __s;
    }

}
namespace std
{

  template<class _CharT>
    struct char_traits : public __gnu_cxx::char_traits<_CharT>
    { };
  template<>
    struct char_traits<char>
    {
      typedef char char_type;
      typedef int int_type;
      typedef streampos pos_type;
      typedef streamoff off_type;
      typedef mbstate_t state_type;
      static void
      assign(char_type& __c1, const char_type& __c2) noexcept
      { __c1 = __c2; }
      static constexpr bool
      eq(const char_type& __c1, const char_type& __c2) noexcept
      { return __c1 == __c2; }
      static constexpr bool
      lt(const char_type& __c1, const char_type& __c2) noexcept
      {
 return (static_cast<unsigned char>(__c1)
  < static_cast<unsigned char>(__c2));
      }
      static int
      compare(const char_type* __s1, const char_type* __s2, size_t __n)
      {
 if (__n == 0)
   return 0;
 return __builtin_memcmp(__s1, __s2, __n);
      }
      static size_t
      length(const char_type* __s)
      {
 return __builtin_strlen(__s);
      }
      static const char_type*
      find(const char_type* __s, size_t __n, const char_type& __a)
      {
 if (__n == 0)
   return 0;
 return static_cast<const char_type*>(__builtin_memchr(__s, __a, __n));
      }
      static char_type*
      move(char_type* __s1, const char_type* __s2, size_t __n)
      {
 if (__n == 0)
   return __s1;
 return static_cast<char_type*>(__builtin_memmove(__s1, __s2, __n));
      }
      static char_type*
      copy(char_type* __s1, const char_type* __s2, size_t __n)
      {
 if (__n == 0)
   return __s1;
 return static_cast<char_type*>(__builtin_memcpy(__s1, __s2, __n));
      }
      static char_type*
      assign(char_type* __s, size_t __n, char_type __a)
      {
 if (__n == 0)
   return __s;
 return static_cast<char_type*>(__builtin_memset(__s, __a, __n));
      }
      static constexpr char_type
      to_char_type(const int_type& __c) noexcept
      { return static_cast<char_type>(__c); }
      static constexpr int_type
      to_int_type(const char_type& __c) noexcept
      { return static_cast<int_type>(static_cast<unsigned char>(__c)); }
      static constexpr bool
      eq_int_type(const int_type& __c1, const int_type& __c2) noexcept
      { return __c1 == __c2; }
      static constexpr int_type
      eof() noexcept
      { return static_cast<int_type>(-1); }
      static constexpr int_type
      not_eof(const int_type& __c) noexcept
      { return (__c == eof()) ? 0 : __c; }
  };
  template<>
    struct char_traits<wchar_t>
    {
      typedef wchar_t char_type;
      typedef wint_t int_type;
      typedef streamoff off_type;
      typedef wstreampos pos_type;
      typedef mbstate_t state_type;
      static void
      assign(char_type& __c1, const char_type& __c2) noexcept
      { __c1 = __c2; }
      static constexpr bool
      eq(const char_type& __c1, const char_type& __c2) noexcept
      { return __c1 == __c2; }
      static constexpr bool
      lt(const char_type& __c1, const char_type& __c2) noexcept
      { return __c1 < __c2; }
      static int
      compare(const char_type* __s1, const char_type* __s2, size_t __n)
      {
 if (__n == 0)
   return 0;
 else
   return wmemcmp(__s1, __s2, __n);
      }
      static size_t
      length(const char_type* __s)
      {
   return wcslen(__s);
      }
      static const char_type*
      find(const char_type* __s, size_t __n, const char_type& __a)
      {
 if (__n == 0)
   return 0;
 else
   return wmemchr(__s, __a, __n);
      }
      static char_type*
      move(char_type* __s1, const char_type* __s2, size_t __n)
      {
 if (__n == 0)
   return __s1;
 return wmemmove(__s1, __s2, __n);
      }
      static char_type*
      copy(char_type* __s1, const char_type* __s2, size_t __n)
      {
 if (__n == 0)
   return __s1;
 return wmemcpy(__s1, __s2, __n);
      }
      static char_type*
      assign(char_type* __s, size_t __n, char_type __a)
      {
 if (__n == 0)
   return __s;
 return wmemset(__s, __a, __n);
      }
      static constexpr char_type
      to_char_type(const int_type& __c) noexcept
      { return char_type(__c); }
      static constexpr int_type
      to_int_type(const char_type& __c) noexcept
      { return int_type(__c); }
      static constexpr bool
      eq_int_type(const int_type& __c1, const int_type& __c2) noexcept
      { return __c1 == __c2; }
      static constexpr int_type
      eof() noexcept
      { return static_cast<int_type>((wint_t)(0xFFFF)); }
      static constexpr int_type
      not_eof(const int_type& __c) noexcept
      { return eq_int_type(__c, eof()) ? 0 : __c; }
  };

}
       
typedef signed char int8_t;
typedef unsigned char uint8_t;
typedef short int16_t;
typedef unsigned short uint16_t;
typedef int int32_t;
typedef unsigned uint32_t;
__extension__ typedef long long int64_t;
__extension__ typedef unsigned long long uint64_t;
typedef signed char int_least8_t;
typedef unsigned char uint_least8_t;
typedef short int_least16_t;
typedef unsigned short uint_least16_t;
typedef int int_least32_t;
typedef unsigned uint_least32_t;
__extension__ typedef long long int_least64_t;
__extension__ typedef unsigned long long uint_least64_t;
typedef signed char int_fast8_t;
typedef unsigned char uint_fast8_t;
typedef short int_fast16_t;
typedef unsigned short uint_fast16_t;
typedef int int_fast32_t;
typedef unsigned int uint_fast32_t;
__extension__ typedef long long int_fast64_t;
__extension__ typedef unsigned long long uint_fast64_t;
__extension__ typedef long long intmax_t;
__extension__ typedef unsigned long long uintmax_t;
namespace std
{
  using ::int8_t;
  using ::int16_t;
  using ::int32_t;
  using ::int64_t;
  using ::int_fast8_t;
  using ::int_fast16_t;
  using ::int_fast32_t;
  using ::int_fast64_t;
  using ::int_least8_t;
  using ::int_least16_t;
  using ::int_least32_t;
  using ::int_least64_t;
  using ::intmax_t;
  using ::intptr_t;
  using ::uint8_t;
  using ::uint16_t;
  using ::uint32_t;
  using ::uint64_t;
  using ::uint_fast8_t;
  using ::uint_fast16_t;
  using ::uint_fast32_t;
  using ::uint_fast64_t;
  using ::uint_least8_t;
  using ::uint_least16_t;
  using ::uint_least32_t;
  using ::uint_least64_t;
  using ::uintmax_t;
  using ::uintptr_t;
}
namespace std
{

  template<>
    struct char_traits<char16_t>
    {
      typedef char16_t char_type;
      typedef uint_least16_t int_type;
      typedef streamoff off_type;
      typedef u16streampos pos_type;
      typedef mbstate_t state_type;
      static void
      assign(char_type& __c1, const char_type& __c2) noexcept
      { __c1 = __c2; }
      static constexpr bool
      eq(const char_type& __c1, const char_type& __c2) noexcept
      { return __c1 == __c2; }
      static constexpr bool
      lt(const char_type& __c1, const char_type& __c2) noexcept
      { return __c1 < __c2; }
      static int
      compare(const char_type* __s1, const char_type* __s2, size_t __n)
      {
 for (size_t __i = 0; __i < __n; ++__i)
   if (lt(__s1[__i], __s2[__i]))
     return -1;
   else if (lt(__s2[__i], __s1[__i]))
     return 1;
 return 0;
      }
      static size_t
      length(const char_type* __s)
      {
 size_t __i = 0;
 while (!eq(__s[__i], char_type()))
   ++__i;
 return __i;
      }
      static const char_type*
      find(const char_type* __s, size_t __n, const char_type& __a)
      {
 for (size_t __i = 0; __i < __n; ++__i)
   if (eq(__s[__i], __a))
     return __s + __i;
 return 0;
      }
      static char_type*
      move(char_type* __s1, const char_type* __s2, size_t __n)
      {
 if (__n == 0)
   return __s1;
 return (static_cast<char_type*>
  (__builtin_memmove(__s1, __s2, __n * sizeof(char_type))));
      }
      static char_type*
      copy(char_type* __s1, const char_type* __s2, size_t __n)
      {
 if (__n == 0)
   return __s1;
 return (static_cast<char_type*>
  (__builtin_memcpy(__s1, __s2, __n * sizeof(char_type))));
      }
      static char_type*
      assign(char_type* __s, size_t __n, char_type __a)
      {
 for (size_t __i = 0; __i < __n; ++__i)
   assign(__s[__i], __a);
 return __s;
      }
      static constexpr char_type
      to_char_type(const int_type& __c) noexcept
      { return char_type(__c); }
      static constexpr int_type
      to_int_type(const char_type& __c) noexcept
      { return __c == eof() ? int_type(0xfffd) : int_type(__c); }
      static constexpr bool
      eq_int_type(const int_type& __c1, const int_type& __c2) noexcept
      { return __c1 == __c2; }
      static constexpr int_type
      eof() noexcept
      { return static_cast<int_type>(-1); }
      static constexpr int_type
      not_eof(const int_type& __c) noexcept
      { return eq_int_type(__c, eof()) ? 0 : __c; }
    };
  template<>
    struct char_traits<char32_t>
    {
      typedef char32_t char_type;
      typedef uint_least32_t int_type;
      typedef streamoff off_type;
      typedef u32streampos pos_type;
      typedef mbstate_t state_type;
      static void
      assign(char_type& __c1, const char_type& __c2) noexcept
      { __c1 = __c2; }
      static constexpr bool
      eq(const char_type& __c1, const char_type& __c2) noexcept
      { return __c1 == __c2; }
      static constexpr bool
      lt(const char_type& __c1, const char_type& __c2) noexcept
      { return __c1 < __c2; }
      static int
      compare(const char_type* __s1, const char_type* __s2, size_t __n)
      {
 for (size_t __i = 0; __i < __n; ++__i)
   if (lt(__s1[__i], __s2[__i]))
     return -1;
   else if (lt(__s2[__i], __s1[__i]))
     return 1;
 return 0;
      }
      static size_t
      length(const char_type* __s)
      {
 size_t __i = 0;
 while (!eq(__s[__i], char_type()))
   ++__i;
 return __i;
      }
      static const char_type*
      find(const char_type* __s, size_t __n, const char_type& __a)
      {
 for (size_t __i = 0; __i < __n; ++__i)
   if (eq(__s[__i], __a))
     return __s + __i;
 return 0;
      }
      static char_type*
      move(char_type* __s1, const char_type* __s2, size_t __n)
      {
 if (__n == 0)
   return __s1;
 return (static_cast<char_type*>
  (__builtin_memmove(__s1, __s2, __n * sizeof(char_type))));
      }
      static char_type*
      copy(char_type* __s1, const char_type* __s2, size_t __n)
      {
 if (__n == 0)
   return __s1;
 return (static_cast<char_type*>
  (__builtin_memcpy(__s1, __s2, __n * sizeof(char_type))));
      }
      static char_type*
      assign(char_type* __s, size_t __n, char_type __a)
      {
 for (size_t __i = 0; __i < __n; ++__i)
   assign(__s[__i], __a);
 return __s;
      }
      static constexpr char_type
      to_char_type(const int_type& __c) noexcept
      { return char_type(__c); }
      static constexpr int_type
      to_int_type(const char_type& __c) noexcept
      { return int_type(__c); }
      static constexpr bool
      eq_int_type(const int_type& __c1, const int_type& __c2) noexcept
      { return __c1 == __c2; }
      static constexpr int_type
      eof() noexcept
      { return static_cast<int_type>(-1); }
      static constexpr int_type
      not_eof(const int_type& __c) noexcept
      { return eq_int_type(__c, eof()) ? 0 : __c; }
    };

}
       
       
       
#pragma pack(push,_CRT_PACKING)
extern "C" {
__attribute__ ((__dllimport__)) FILE *__attribute__((__cdecl__)) __acrt_iob_func(unsigned index);
  __attribute__ ((__dllimport__)) FILE *__attribute__((__cdecl__)) __iob_func(void);
  __extension__ typedef long long fpos_t;
extern
  __attribute__((__format__ (gnu_scanf, 2, 3))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_sscanf(const char * __restrict__ _Src,const char * __restrict__ _Format,...);
extern
  __attribute__((__format__ (gnu_scanf, 2, 0))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_vsscanf (const char * __restrict__ _Str,const char * __restrict__ Format,va_list argp);
extern
  __attribute__((__format__ (gnu_scanf, 1, 2))) __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __mingw_scanf(const char * __restrict__ _Format,...);
extern
  __attribute__((__format__ (gnu_scanf, 1, 0))) __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __mingw_vscanf(const char * __restrict__ Format, va_list argp);
extern
  __attribute__((__format__ (gnu_scanf, 2, 3))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_fscanf(FILE * __restrict__ _File,const char * __restrict__ _Format,...);
extern
  __attribute__((__format__ (gnu_scanf, 2, 0))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_vfscanf (FILE * __restrict__ fp, const char * __restrict__ Format,va_list argp);
extern
  __attribute__((__format__ (gnu_printf, 3, 0))) __attribute__ ((__nonnull__ (3)))
  int __attribute__((__cdecl__)) __mingw_vsnprintf(char * __restrict__ _DstBuf,size_t _MaxCount,const char * __restrict__ _Format,
                               va_list _ArgList);
extern
  __attribute__((__format__ (gnu_printf, 3, 4))) __attribute__ ((__nonnull__ (3)))
  int __attribute__((__cdecl__)) __mingw_snprintf(char * __restrict__ s, size_t n, const char * __restrict__ format, ...);
extern
  __attribute__((__format__ (gnu_printf, 1, 2))) __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __mingw_printf(const char * __restrict__ , ... ) __attribute__ ((__nothrow__));
extern
  __attribute__((__format__ (gnu_printf, 1, 0))) __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __mingw_vprintf (const char * __restrict__ , va_list) __attribute__ ((__nothrow__));
extern
  __attribute__((__format__ (gnu_printf, 2, 3))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_fprintf (FILE * __restrict__ , const char * __restrict__ , ...) __attribute__ ((__nothrow__));
extern
  __attribute__((__format__ (gnu_printf, 2, 0))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_vfprintf (FILE * __restrict__ , const char * __restrict__ , va_list) __attribute__ ((__nothrow__));
extern
  __attribute__((__format__ (gnu_printf, 2, 3))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_sprintf (char * __restrict__ , const char * __restrict__ , ...) __attribute__ ((__nothrow__));
extern
  __attribute__((__format__ (gnu_printf, 2, 0))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_vsprintf (char * __restrict__ , const char * __restrict__ , va_list) __attribute__ ((__nothrow__));
extern
  __attribute__((__format__ (gnu_printf, 2, 3))) __attribute__((nonnull (1,2)))
  int __attribute__((__cdecl__)) __mingw_asprintf(char ** __restrict__ , const char * __restrict__ , ...) __attribute__ ((__nothrow__));
extern
  __attribute__((__format__ (gnu_printf, 2, 0))) __attribute__((nonnull (1,2)))
  int __attribute__((__cdecl__)) __mingw_vasprintf(char ** __restrict__ , const char * __restrict__ , va_list) __attribute__ ((__nothrow__));
extern "C++" {
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
__attribute__((__format__ (gnu_scanf, 2, 3))) __attribute__ ((__nonnull__ (2)))
int sscanf(const char *__source, const char *__format, ...)
{
  int __retval;
  __builtin_va_list __local_argv; __builtin_va_start( __local_argv, __format );
  __retval = __mingw_vsscanf( __source, __format, __local_argv );
  __builtin_va_end( __local_argv );
  return __retval;
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
__attribute__((__format__ (gnu_scanf, 1, 2))) __attribute__ ((__nonnull__ (1)))
int scanf(const char *__format, ...)
{
  int __retval;
  __builtin_va_list __local_argv; __builtin_va_start( __local_argv, __format );
  __retval = __mingw_vfscanf( (__acrt_iob_func(0)), __format, __local_argv );
  __builtin_va_end( __local_argv );
  return __retval;
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
__attribute__((__format__ (gnu_scanf, 2, 3))) __attribute__ ((__nonnull__ (2)))
int fscanf(FILE *__stream, const char *__format, ...)
{
  int __retval;
  __builtin_va_list __local_argv; __builtin_va_start( __local_argv, __format );
  __retval = __mingw_vfscanf( __stream, __format, __local_argv );
  __builtin_va_end( __local_argv );
  return __retval;
}
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wshadow"
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
__attribute__((__format__ (gnu_scanf, 2, 0))) __attribute__ ((__nonnull__ (2)))
int vsscanf (const char *__source, const char *__format, __builtin_va_list __local_argv)
{
  return __mingw_vsscanf( __source, __format, __local_argv );
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
__attribute__((__format__ (gnu_scanf, 1, 0))) __attribute__ ((__nonnull__ (1)))
int vscanf(const char *__format, __builtin_va_list __local_argv)
{
  return __mingw_vfscanf( (__acrt_iob_func(0)), __format, __local_argv );
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
__attribute__((__format__ (gnu_scanf, 2, 0))) __attribute__ ((__nonnull__ (2)))
int vfscanf (FILE *__stream, const char *__format, __builtin_va_list __local_argv)
{
  return __mingw_vfscanf( __stream, __format, __local_argv );
}
#pragma GCC diagnostic pop
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
__attribute__((__format__ (gnu_printf, 2, 3))) __attribute__ ((__nonnull__ (2)))
int fprintf (FILE *__stream, const char *__format, ...)
{
  int __retval;
  __builtin_va_list __local_argv; __builtin_va_start( __local_argv, __format );
  __retval = __mingw_vfprintf( __stream, __format, __local_argv );
  __builtin_va_end( __local_argv );
  return __retval;
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
__attribute__((__format__ (gnu_printf, 1, 2))) __attribute__ ((__nonnull__ (1)))
int printf (const char *__format, ...)
{
  int __retval;
  __builtin_va_list __local_argv; __builtin_va_start( __local_argv, __format );
  __retval = __mingw_vfprintf( (__acrt_iob_func(1)), __format, __local_argv );
  __builtin_va_end( __local_argv );
  return __retval;
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
__attribute__((__format__ (gnu_printf, 2, 3))) __attribute__ ((__nonnull__ (2)))
int sprintf (char *__stream, const char *__format, ...)
{
  int __retval;
  __builtin_va_list __local_argv; __builtin_va_start( __local_argv, __format );
  __retval = __mingw_vsprintf( __stream, __format, __local_argv );
  __builtin_va_end( __local_argv );
  return __retval;
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
__attribute__((__format__ (gnu_printf, 2, 0))) __attribute__ ((__nonnull__ (2)))
int vfprintf (FILE *__stream, const char *__format, __builtin_va_list __local_argv)
{
  return __mingw_vfprintf( __stream, __format, __local_argv );
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
__attribute__((__format__ (gnu_printf, 1, 0))) __attribute__ ((__nonnull__ (1)))
int vprintf (const char *__format, __builtin_va_list __local_argv)
{
  return __mingw_vfprintf( (__acrt_iob_func(1)), __format, __local_argv );
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
__attribute__((__format__ (gnu_printf, 2, 0))) __attribute__ ((__nonnull__ (2)))
int vsprintf (char *__stream, const char *__format, __builtin_va_list __local_argv)
{
  return __mingw_vsprintf( __stream, __format, __local_argv );
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
__attribute__((__format__ (gnu_printf, 3, 4))) __attribute__ ((__nonnull__ (3)))
int snprintf (char *__stream, size_t __n, const char *__format, ...)
{
  int __retval;
  __builtin_va_list __local_argv; __builtin_va_start( __local_argv, __format );
  __retval = __mingw_vsnprintf( __stream, __n, __format, __local_argv );
  __builtin_va_end( __local_argv );
  return __retval;
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
__attribute__((__format__ (gnu_printf, 3, 0))) __attribute__ ((__nonnull__ (3)))
int vsnprintf (char *__stream, size_t __n, const char *__format, __builtin_va_list __local_argv)
{
  return __mingw_vsnprintf( __stream, __n, __format, __local_argv );
}
}
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _filbuf(FILE *_File);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _flsbuf(int _Ch,FILE *_File);
  __attribute__ ((__dllimport__)) FILE *__attribute__((__cdecl__)) _fsopen(const char *_Filename,const char *_Mode,int _ShFlag);
  void __attribute__((__cdecl__)) clearerr(FILE *_File);
  int __attribute__((__cdecl__)) fclose(FILE *_File);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fcloseall(void);
  __attribute__ ((__dllimport__)) FILE *__attribute__((__cdecl__)) _fdopen(int _FileHandle,const char *_Mode);
  int __attribute__((__cdecl__)) feof(FILE *_File);
  int __attribute__((__cdecl__)) ferror(FILE *_File);
  int __attribute__((__cdecl__)) fflush(FILE *_File);
  int __attribute__((__cdecl__)) fgetc(FILE *_File);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fgetchar(void);
  int __attribute__((__cdecl__)) fgetpos(FILE * __restrict__ _File ,fpos_t * __restrict__ _Pos);
  int __attribute__((__cdecl__)) fgetpos64(FILE * __restrict__ _File ,fpos_t * __restrict__ _Pos);
  char *__attribute__((__cdecl__)) fgets(char * __restrict__ _Buf,int _MaxCount,FILE * __restrict__ _File);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fileno(FILE *_File);
  __attribute__ ((__dllimport__)) char *__attribute__((__cdecl__)) _tempnam(const char *_DirName,const char *_FilePrefix);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _flushall(void);
  FILE *__attribute__((__cdecl__)) fopen(const char * __restrict__ _Filename,const char * __restrict__ _Mode) ;
  FILE *fopen64(const char * __restrict__ filename,const char * __restrict__ mode);
  int __attribute__((__cdecl__)) fputc(int _Ch,FILE *_File);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fputchar(int _Ch);
  int __attribute__((__cdecl__)) fputs(const char * __restrict__ _Str,FILE * __restrict__ _File);
  size_t __attribute__((__cdecl__)) fread(void * __restrict__ _DstBuf,size_t _ElementSize,size_t _Count,FILE * __restrict__ _File);
  FILE *__attribute__((__cdecl__)) freopen(const char * __restrict__ _Filename,const char * __restrict__ _Mode,FILE * __restrict__ _File) ;
  int __attribute__((__cdecl__)) fsetpos(FILE *_File,const fpos_t *_Pos);
  int __attribute__((__cdecl__)) fsetpos64(FILE *_File,const fpos_t *_Pos);
  int __attribute__((__cdecl__)) fseek(FILE *_File,long _Offset,int _Origin);
  long __attribute__((__cdecl__)) ftell(FILE *_File);
  __extension__ int __attribute__((__cdecl__)) _fseeki64(FILE *_File,long long _Offset,int _Origin);
  __extension__ long long __attribute__((__cdecl__)) _ftelli64(FILE *_File);
  int fseeko64(FILE* stream, _off64_t offset, int whence);
  int fseeko(FILE* stream, _off_t offset, int whence);
  _off_t ftello(FILE * stream);
  _off64_t ftello64(FILE * stream);
  size_t __attribute__((__cdecl__)) fwrite(const void * __restrict__ _Str,size_t _Size,size_t _Count,FILE * __restrict__ _File);
  int __attribute__((__cdecl__)) getc(FILE *_File);
  int __attribute__((__cdecl__)) getchar(void);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _getmaxstdio(void);
  char *__attribute__((__cdecl__)) gets(char *_Buffer) ;
  int __attribute__((__cdecl__)) _getw(FILE *_File);
  void __attribute__((__cdecl__)) perror(const char *_ErrMsg);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _pclose(FILE *_File);
  __attribute__ ((__dllimport__)) FILE *__attribute__((__cdecl__)) _popen(const char *_Command,const char *_Mode);
  int __attribute__((__cdecl__)) putc(int _Ch,FILE *_File);
  int __attribute__((__cdecl__)) putchar(int _Ch);
  int __attribute__((__cdecl__)) puts(const char *_Str);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _putw(int _Word,FILE *_File);
  int __attribute__((__cdecl__)) remove(const char *_Filename);
  int __attribute__((__cdecl__)) rename(const char *_OldFilename,const char *_NewFilename);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _unlink(const char *_Filename);
  int __attribute__((__cdecl__)) unlink(const char *_Filename) ;
  void __attribute__((__cdecl__)) rewind(FILE *_File);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _rmtmp(void);
  void __attribute__((__cdecl__)) setbuf(FILE * __restrict__ _File,char * __restrict__ _Buffer) ;
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _setmaxstdio(int _Max);
  __attribute__ ((__dllimport__)) unsigned int __attribute__((__cdecl__)) _set_output_format(unsigned int _Format);
  __attribute__ ((__dllimport__)) unsigned int __attribute__((__cdecl__)) _get_output_format(void);
  int __attribute__((__cdecl__)) setvbuf(FILE * __restrict__ _File,char * __restrict__ _Buf,int _Mode,size_t _Size);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _scprintf(const char * __restrict__ _Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snscanf(const char * __restrict__ _Src,size_t _MaxCount,const char * __restrict__ _Format,...) ;
  FILE *__attribute__((__cdecl__)) tmpfile(void) ;
  char *__attribute__((__cdecl__)) tmpnam(char *_Buffer);
  int __attribute__((__cdecl__)) ungetc(int _Ch,FILE *_File);
  __attribute__((__format__ (ms_printf, 3, 4))) __attribute__ ((__nonnull__ (3)))
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snprintf(char * __restrict__ _Dest,size_t _Count,const char * __restrict__ _Format,...) ;
  __attribute__((__format__ (ms_printf, 3, 0))) __attribute__ ((__nonnull__ (3)))
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsnprintf(char * __restrict__ _Dest,size_t _Count,const char * __restrict__ _Format,va_list _Args) ;
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vscprintf(const char * __restrict__ _Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _set_printf_count_output(int _Value);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _get_printf_count_output(void);
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _lock_file(FILE *_File);
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _unlock_file(FILE *_File);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fclose_nolock(FILE *_File);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fflush_nolock(FILE *_File);
  __attribute__ ((__dllimport__)) size_t __attribute__((__cdecl__)) _fread_nolock(void * __restrict__ _DstBuf,size_t _ElementSize,size_t _Count,FILE * __restrict__ _File);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fseek_nolock(FILE *_File,long _Offset,int _Origin);
  __attribute__ ((__dllimport__)) long __attribute__((__cdecl__)) _ftell_nolock(FILE *_File);
  __extension__ __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fseeki64_nolock(FILE *_File,long long _Offset,int _Origin);
  __extension__ __attribute__ ((__dllimport__)) long long __attribute__((__cdecl__)) _ftelli64_nolock(FILE *_File);
  __attribute__ ((__dllimport__)) size_t __attribute__((__cdecl__)) _fwrite_nolock(const void * __restrict__ _DstBuf,size_t _Size,size_t _Count,FILE * __restrict__ _File);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _ungetc_nolock(int _Ch,FILE *_File);
  char *__attribute__((__cdecl__)) tempnam(const char *_Directory,const char *_FilePrefix) ;
  int __attribute__((__cdecl__)) fcloseall(void) ;
  FILE *__attribute__((__cdecl__)) fdopen(int _FileHandle,const char *_Format) ;
  int __attribute__((__cdecl__)) fgetchar(void) ;
  int __attribute__((__cdecl__)) fileno(FILE *_File) ;
  int __attribute__((__cdecl__)) flushall(void) ;
  int __attribute__((__cdecl__)) fputchar(int _Ch) ;
  int __attribute__((__cdecl__)) getw(FILE *_File) ;
  int __attribute__((__cdecl__)) putw(int _Ch,FILE *_File) ;
  int __attribute__((__cdecl__)) rmtmp(void) ;
}
#pragma pack(pop)
extern "C" {
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) clearerr_s(FILE *_File);
  size_t __attribute__((__cdecl__)) fread_s(void *_DstBuf,size_t _DstSize,size_t _ElementSize,size_t _Count,FILE *_File);
  int __attribute__((__cdecl__)) fprintf_s(FILE *_File,const char *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fscanf_s_l(FILE *_File,const char *_Format,_locale_t _Locale,...);
  int __attribute__((__cdecl__)) printf_s(const char *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _scanf_l(const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _scanf_s_l(const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snprintf_c(char *_DstBuf,size_t _MaxCount,const char *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsnprintf_c(char *_DstBuf,size_t _MaxCount,const char *_Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fscanf_l(FILE *_File,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _sscanf_l(const char *_Src,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _sscanf_s_l(const char *_Src,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) sscanf_s(const char *_Src,const char *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snscanf_s(const char *_Src,size_t _MaxCount,const char *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snscanf_l(const char *_Src,size_t _MaxCount,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snscanf_s_l(const char *_Src,size_t _MaxCount,const char *_Format,_locale_t _Locale,...);
  int __attribute__((__cdecl__)) vfprintf_s(FILE *_File,const char *_Format,va_list _ArgList);
  int __attribute__((__cdecl__)) vprintf_s(const char *_Format,va_list _ArgList);
  int __attribute__((__cdecl__)) vsnprintf_s(char *_DstBuf,size_t _DstSize,size_t _MaxCount,const char *_Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsnprintf_s(char *_DstBuf,size_t _DstSize,size_t _MaxCount,const char *_Format,va_list _ArgList);
  __attribute__((dllimport)) int __attribute__((__cdecl__)) vsprintf_s(char *_DstBuf,size_t _Size,const char *_Format,va_list _ArgList);
  __attribute__((dllimport)) int __attribute__((__cdecl__)) sprintf_s(char *_DstBuf,size_t _DstSize,const char *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snprintf_s(char *_DstBuf,size_t _DstSize,size_t _MaxCount,const char *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fprintf_p(FILE *_File,const char *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _printf_p(const char *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _sprintf_p(char *_Dst,size_t _MaxCount,const char *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vfprintf_p(FILE *_File,const char *_Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vprintf_p(const char *_Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsprintf_p(char *_Dst,size_t _MaxCount,const char *_Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _scprintf_p(const char *_Format,...);
  __attribute__((dllimport)) int __attribute__((__cdecl__)) _vscprintf_p(const char *_Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _printf_l(const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _printf_p_l(const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vprintf_l(const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vprintf_p_l(const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fprintf_l(FILE *_File,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fprintf_p_l(FILE *_File,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vfprintf_l(FILE *_File,const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vfprintf_p_l(FILE *_File,const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _sprintf_l(char *_DstBuf,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _sprintf_p_l(char *_DstBuf,size_t _MaxCount,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsprintf_l(char *_DstBuf,const char *_Format,_locale_t,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsprintf_p_l(char *_DstBuf,size_t _MaxCount,const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _scprintf_l(const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _scprintf_p_l(const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vscprintf_l(const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vscprintf_p_l(const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _printf_s_l(const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vprintf_s_l(const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fprintf_s_l(FILE *_File,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vfprintf_s_l(FILE *_File,const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _sprintf_s_l(char *_DstBuf,size_t _DstSize,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsprintf_s_l(char *_DstBuf,size_t _DstSize,const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snprintf_s_l(char *_DstBuf,size_t _DstSize,size_t _MaxCount,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsnprintf_s_l(char *_DstBuf,size_t _DstSize,size_t _MaxCount,const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snprintf_l(char *_DstBuf,size_t _MaxCount,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snprintf_c_l(char *_DstBuf,size_t _MaxCount,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsnprintf_l(char *_DstBuf,size_t _MaxCount,const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsnprintf_c_l(char *_DstBuf,size_t _MaxCount,const char *,_locale_t _Locale,va_list _ArgList);
  extern "C++" { template <size_t __size> inline int __attribute__((__cdecl__)) vsnprintf_s(char (&_DstBuf)[__size], size_t _MaxCount, const char* _Format, va_list _ArgList) { return vsnprintf_s(_DstBuf,__size,_MaxCount,_Format,_ArgList); } }
  extern "C++" { template <size_t __size> inline int __attribute__((__cdecl__)) _vsnprintf_s(char (&_DstBuf)[__size], size_t _MaxCount, const char* _Format, va_list _ArgList) { return _vsnprintf_s(_DstBuf,__size,_MaxCount,_Format,_ArgList); } }
  extern "C++" { template <size_t __size> inline int __attribute__((__cdecl__)) vsprintf_s(char (&_DstBuf)[__size], const char* _Format, va_list _ArgList) { return vsprintf_s(_DstBuf,__size,_Format,_ArgList); } }
  extern "C++" { template <size_t __size> inline int __attribute__((__cdecl__)) sprintf_s(char (&_DstBuf)[__size], const char* _Format, ...) { va_list __vaargs; __builtin_va_start(__vaargs,_Format); int __retval = vsprintf_s(_DstBuf,__size,_Format,__vaargs); __builtin_va_end(__vaargs); return __retval; } }
  extern "C++" { template <size_t __size> inline int __attribute__((__cdecl__)) _snprintf_s(char (&_DstBuf)[__size], size_t _MaxCount, const char* _Format, ...) { va_list __vaargs; __builtin_va_start(__vaargs,_Format); int __retval = _vsnprintf_s(_DstBuf,__size,_MaxCount,_Format,__vaargs); __builtin_va_end(__vaargs); return __retval; } }
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) fopen_s(FILE **_File,const char *_Filename,const char *_Mode);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) freopen_s(FILE** _File, const char *_Filename, const char *_Mode, FILE *_Stream);
  __attribute__ ((__dllimport__)) char* __attribute__((__cdecl__)) gets_s(char*,rsize_t);
  extern "C++" { template <size_t __size> inline char* __attribute__((__cdecl__)) get_s(char (&_DstBuf)[__size]) { return get_s(_DstBuf,__size); } }
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) tmpnam_s(char*,rsize_t);
  extern "C++" { template <size_t __size> inline errno_t __attribute__((__cdecl__)) tmpnam_s(char (&_DstBuf)[__size]) { return tmpnam_s(_DstBuf,__size); } }
  __attribute__ ((__dllimport__)) size_t __attribute__((__cdecl__)) _fread_nolock_s(void *_DstBuf,size_t _DstSize,size_t _ElementSize,size_t _Count,FILE *_File);
}
#pragma pack(push,_CRT_PACKING)
extern "C" {
  struct lconv {
    char *decimal_point;
    char *thousands_sep;
    char *grouping;
    char *int_curr_symbol;
    char *currency_symbol;
    char *mon_decimal_point;
    char *mon_thousands_sep;
    char *mon_grouping;
    char *positive_sign;
    char *negative_sign;
    char int_frac_digits;
    char frac_digits;
    char p_cs_precedes;
    char p_sep_by_space;
    char n_cs_precedes;
    char n_sep_by_space;
    char p_sign_posn;
    char n_sign_posn;
  };
  int __attribute__((__cdecl__)) _configthreadlocale(int _Flag);
  char *__attribute__((__cdecl__)) setlocale(int _Category,const char *_Locale);
  __attribute__ ((__dllimport__)) struct lconv *__attribute__((__cdecl__)) localeconv(void);
  __attribute__ ((__dllimport__)) _locale_t __attribute__((__cdecl__)) _get_current_locale(void);
  _locale_t __attribute__((__cdecl__)) _create_locale(int _Category,const char *_Locale);
  void __attribute__((__cdecl__)) _free_locale(_locale_t _Locale);
  _locale_t __attribute__((__cdecl__)) __get_current_locale(void);
  _locale_t __attribute__((__cdecl__)) __create_locale(int _Category,const char *_Locale);
  void __attribute__((__cdecl__)) __free_locale(_locale_t _Locale);
}
#pragma pack(pop)
namespace std
{
  using ::lconv;
  using ::setlocale;
  using ::localeconv;
}
namespace std
{

  typedef int* __c_locale;
  inline int
  __convert_from_v(const __c_locale&, char* __out,
     const int __size __attribute__((__unused__)),
     const char* __fmt, ...)
  {
    char* __old = std::setlocale(4, 0);
    char* __sav = 0;
    if (__builtin_strcmp(__old, "C"))
      {
 const size_t __len = __builtin_strlen(__old) + 1;
 __sav = new char[__len];
 __builtin_memcpy(__sav, __old, __len);
 std::setlocale(4, "C");
      }
    __builtin_va_list __args;
    __builtin_va_start(__args, __fmt);
    const int __ret = __mingw_vsnprintf(__out, __size, __fmt, __args);
    __builtin_va_end(__args);
    if (__sav)
      {
 std::setlocale(4, __sav);
 delete [] __sav;
      }
    return __ret;
  }

}
       
extern "C" {
  extern const unsigned char __newclmap[];
  extern const unsigned char __newcumap[];
  extern pthreadlocinfo __ptlocinfo;
  extern pthreadmbcinfo __ptmbcinfo;
  extern int __globallocalestatus;
  extern int __locale_changed;
  extern struct threadlocaleinfostruct __initiallocinfo;
  extern _locale_tstruct __initiallocalestructinfo;
  pthreadlocinfo __attribute__((__cdecl__)) __updatetlocinfo(void);
  pthreadmbcinfo __attribute__((__cdecl__)) __updatetmbcinfo(void);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _isctype(int _C,int _Type);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _isctype_l(int _C,int _Type,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) isalpha(int _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _isalpha_l(int _C,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) isupper(int _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _isupper_l(int _C,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) islower(int _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _islower_l(int _C,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) isdigit(int _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _isdigit_l(int _C,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) isxdigit(int _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _isxdigit_l(int _C,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) isspace(int _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _isspace_l(int _C,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) ispunct(int _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _ispunct_l(int _C,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) isalnum(int _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _isalnum_l(int _C,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) isprint(int _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _isprint_l(int _C,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) isgraph(int _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _isgraph_l(int _C,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) iscntrl(int _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _iscntrl_l(int _C,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) toupper(int _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) tolower(int _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _tolower(int _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _tolower_l(int _C,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _toupper(int _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _toupper_l(int _C,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) __isascii(int _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) __toascii(int _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) __iscsymf(int _C);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) __iscsym(int _C);
int __attribute__((__cdecl__)) isblank(int _C);
  extern int * __imp___mb_cur_max;
__attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) ___mb_cur_max_func(void);
}
namespace std
{
  using ::isalnum;
  using ::isalpha;
  using ::iscntrl;
  using ::isdigit;
  using ::isgraph;
  using ::islower;
  using ::isprint;
  using ::ispunct;
  using ::isspace;
  using ::isupper;
  using ::isxdigit;
  using ::tolower;
  using ::toupper;
}
namespace std
{
  using ::isblank;
}
namespace std
{

  class locale;
  template<typename _Facet>
    bool
    has_facet(const locale&) throw();
  template<typename _Facet>
    const _Facet&
    use_facet(const locale&);
  template<typename _CharT>
    bool
    isspace(_CharT, const locale&);
  template<typename _CharT>
    bool
    isprint(_CharT, const locale&);
  template<typename _CharT>
    bool
    iscntrl(_CharT, const locale&);
  template<typename _CharT>
    bool
    isupper(_CharT, const locale&);
  template<typename _CharT>
    bool
    islower(_CharT, const locale&);
  template<typename _CharT>
    bool
    isalpha(_CharT, const locale&);
  template<typename _CharT>
    bool
    isdigit(_CharT, const locale&);
  template<typename _CharT>
    bool
    ispunct(_CharT, const locale&);
  template<typename _CharT>
    bool
    isxdigit(_CharT, const locale&);
  template<typename _CharT>
    bool
    isalnum(_CharT, const locale&);
  template<typename _CharT>
    bool
    isgraph(_CharT, const locale&);
  template<typename _CharT>
    bool
    isblank(_CharT, const locale&);
  template<typename _CharT>
    _CharT
    toupper(_CharT, const locale&);
  template<typename _CharT>
    _CharT
    tolower(_CharT, const locale&);
  class ctype_base;
  template<typename _CharT>
    class ctype;
  template<> class ctype<char>;
  template<> class ctype<wchar_t>;
  template<typename _CharT>
    class ctype_byname;
  class codecvt_base;
  template<typename _InternT, typename _ExternT, typename _StateT>
    class codecvt;
  template<> class codecvt<char, char, mbstate_t>;
  template<> class codecvt<wchar_t, char, mbstate_t>;
  template<typename _InternT, typename _ExternT, typename _StateT>
    class codecvt_byname;

  template<typename _CharT, typename _InIter = istreambuf_iterator<_CharT> >
    class num_get;
  template<typename _CharT, typename _OutIter = ostreambuf_iterator<_CharT> >
    class num_put;

namespace __cxx11 {
  template<typename _CharT> class numpunct;
  template<typename _CharT> class numpunct_byname;
}
namespace __cxx11 {
  template<typename _CharT>
    class collate;
  template<typename _CharT>
    class collate_byname;
}
  class time_base;
namespace __cxx11 {
  template<typename _CharT, typename _InIter = istreambuf_iterator<_CharT> >
    class time_get;
  template<typename _CharT, typename _InIter = istreambuf_iterator<_CharT> >
    class time_get_byname;
}
  template<typename _CharT, typename _OutIter = ostreambuf_iterator<_CharT> >
    class time_put;
  template<typename _CharT, typename _OutIter = ostreambuf_iterator<_CharT> >
    class time_put_byname;
  class money_base;
namespace __cxx11 {
  template<typename _CharT, typename _InIter = istreambuf_iterator<_CharT> >
    class money_get;
  template<typename _CharT, typename _OutIter = ostreambuf_iterator<_CharT> >
    class money_put;
}
namespace __cxx11 {
  template<typename _CharT, bool _Intl = false>
    class moneypunct;
  template<typename _CharT, bool _Intl = false>
    class moneypunct_byname;
}
  class messages_base;
namespace __cxx11 {
  template<typename _CharT>
    class messages;
  template<typename _CharT>
    class messages_byname;
}

}
       
       
#pragma GCC visibility push(default)
namespace __cxxabiv1
{
  class __forced_unwind
  {
    virtual ~__forced_unwind() throw();
    virtual void __pure_dummy() = 0;
  };
}
#pragma GCC visibility pop
namespace std
{

  template<typename _CharT, typename _Traits>
    inline void
    __ostream_write(basic_ostream<_CharT, _Traits>& __out,
      const _CharT* __s, streamsize __n)
    {
      typedef basic_ostream<_CharT, _Traits> __ostream_type;
      typedef typename __ostream_type::ios_base __ios_base;
      const streamsize __put = __out.rdbuf()->sputn(__s, __n);
      if (__put != __n)
 __out.setstate(__ios_base::badbit);
    }
  template<typename _CharT, typename _Traits>
    inline void
    __ostream_fill(basic_ostream<_CharT, _Traits>& __out, streamsize __n)
    {
      typedef basic_ostream<_CharT, _Traits> __ostream_type;
      typedef typename __ostream_type::ios_base __ios_base;
      const _CharT __c = __out.fill();
      for (; __n > 0; --__n)
 {
   const typename _Traits::int_type __put = __out.rdbuf()->sputc(__c);
   if (_Traits::eq_int_type(__put, _Traits::eof()))
     {
       __out.setstate(__ios_base::badbit);
       break;
     }
 }
    }
  template<typename _CharT, typename _Traits>
    basic_ostream<_CharT, _Traits>&
    __ostream_insert(basic_ostream<_CharT, _Traits>& __out,
       const _CharT* __s, streamsize __n)
    {
      typedef basic_ostream<_CharT, _Traits> __ostream_type;
      typedef typename __ostream_type::ios_base __ios_base;
      typename __ostream_type::sentry __cerb(__out);
      if (__cerb)
 {
   try
     {
       const streamsize __w = __out.width();
       if (__w > __n)
  {
    const bool __left = ((__out.flags()
     & __ios_base::adjustfield)
           == __ios_base::left);
    if (!__left)
      __ostream_fill(__out, __w - __n);
    if (__out.good())
      __ostream_write(__out, __s, __n);
    if (__left && __out.good())
      __ostream_fill(__out, __w - __n);
  }
       else
  __ostream_write(__out, __s, __n);
       __out.width(0);
     }
   catch(__cxxabiv1::__forced_unwind&)
     {
       __out._M_setstate(__ios_base::badbit);
       throw;
     }
   catch(...)
     { __out._M_setstate(__ios_base::badbit); }
 }
      return __out;
    }
  extern template ostream& __ostream_insert(ostream&, const char*, streamsize);
  extern template wostream& __ostream_insert(wostream&, const wchar_t*,
          streamsize);

}
       
namespace std
{

  template<typename _Container>
    inline auto
    begin(_Container& __cont) -> decltype(__cont.begin())
    { return __cont.begin(); }
  template<typename _Container>
    inline auto
    begin(const _Container& __cont) -> decltype(__cont.begin())
    { return __cont.begin(); }
  template<typename _Container>
    inline auto
    end(_Container& __cont) -> decltype(__cont.end())
    { return __cont.end(); }
  template<typename _Container>
    inline auto
    end(const _Container& __cont) -> decltype(__cont.end())
    { return __cont.end(); }
  template<typename _Tp, size_t _Nm>
    inline constexpr _Tp*
    begin(_Tp (&__arr)[_Nm])
    { return __arr; }
  template<typename _Tp, size_t _Nm>
    inline constexpr _Tp*
    end(_Tp (&__arr)[_Nm])
    { return __arr + _Nm; }
  template<typename _Tp> class valarray;
  template<typename _Tp> _Tp* begin(valarray<_Tp>&);
  template<typename _Tp> const _Tp* begin(const valarray<_Tp>&);
  template<typename _Tp> _Tp* end(valarray<_Tp>&);
  template<typename _Tp> const _Tp* end(const valarray<_Tp>&);
  template<typename _Container>
    inline constexpr auto
    cbegin(const _Container& __cont) noexcept(noexcept(std::begin(__cont)))
      -> decltype(std::begin(__cont))
    { return std::begin(__cont); }
  template<typename _Container>
    inline constexpr auto
    cend(const _Container& __cont) noexcept(noexcept(std::end(__cont)))
      -> decltype(std::end(__cont))
    { return std::end(__cont); }
  template<typename _Container>
    inline auto
    rbegin(_Container& __cont) -> decltype(__cont.rbegin())
    { return __cont.rbegin(); }
  template<typename _Container>
    inline auto
    rbegin(const _Container& __cont) -> decltype(__cont.rbegin())
    { return __cont.rbegin(); }
  template<typename _Container>
    inline auto
    rend(_Container& __cont) -> decltype(__cont.rend())
    { return __cont.rend(); }
  template<typename _Container>
    inline auto
    rend(const _Container& __cont) -> decltype(__cont.rend())
    { return __cont.rend(); }
  template<typename _Tp, size_t _Nm>
    inline reverse_iterator<_Tp*>
    rbegin(_Tp (&__arr)[_Nm])
    { return reverse_iterator<_Tp*>(__arr + _Nm); }
  template<typename _Tp, size_t _Nm>
    inline reverse_iterator<_Tp*>
    rend(_Tp (&__arr)[_Nm])
    { return reverse_iterator<_Tp*>(__arr); }
  template<typename _Tp>
    inline reverse_iterator<const _Tp*>
    rbegin(initializer_list<_Tp> __il)
    { return reverse_iterator<const _Tp*>(__il.end()); }
  template<typename _Tp>
    inline reverse_iterator<const _Tp*>
    rend(initializer_list<_Tp> __il)
    { return reverse_iterator<const _Tp*>(__il.begin()); }
  template<typename _Container>
    inline auto
    crbegin(const _Container& __cont) -> decltype(std::rbegin(__cont))
    { return std::rbegin(__cont); }
  template<typename _Container>
    inline auto
    crend(const _Container& __cont) -> decltype(std::rend(__cont))
    { return std::rend(__cont); }

}
       
namespace std
{

namespace __cxx11 {
  template<typename _CharT, typename _Traits, typename _Alloc>
    class basic_string
    {
      typedef typename __gnu_cxx::__alloc_traits<_Alloc>::template
 rebind<_CharT>::other _Char_alloc_type;
      typedef __gnu_cxx::__alloc_traits<_Char_alloc_type> _Alloc_traits;
    public:
      typedef _Traits traits_type;
      typedef typename _Traits::char_type value_type;
      typedef _Char_alloc_type allocator_type;
      typedef typename _Alloc_traits::size_type size_type;
      typedef typename _Alloc_traits::difference_type difference_type;
      typedef typename _Alloc_traits::reference reference;
      typedef typename _Alloc_traits::const_reference const_reference;
      typedef typename _Alloc_traits::pointer pointer;
      typedef typename _Alloc_traits::const_pointer const_pointer;
      typedef __gnu_cxx::__normal_iterator<pointer, basic_string> iterator;
      typedef __gnu_cxx::__normal_iterator<const_pointer, basic_string>
       const_iterator;
      typedef std::reverse_iterator<const_iterator> const_reverse_iterator;
      typedef std::reverse_iterator<iterator> reverse_iterator;
      static const size_type npos = static_cast<size_type>(-1);
    private:
      typedef const_iterator __const_iterator;
      struct _Alloc_hider : allocator_type
      {
 _Alloc_hider(pointer __dat, const _Alloc& __a)
 : allocator_type(__a), _M_p(__dat) { }
 _Alloc_hider(pointer __dat, _Alloc&& __a = _Alloc())
 : allocator_type(std::move(__a)), _M_p(__dat) { }
 pointer _M_p;
      };
      _Alloc_hider _M_dataplus;
      size_type _M_string_length;
      enum { _S_local_capacity = 15 / sizeof(_CharT) };
      union
      {
 _CharT _M_local_buf[_S_local_capacity + 1];
 size_type _M_allocated_capacity;
      };
      void
      _M_data(pointer __p)
      { _M_dataplus._M_p = __p; }
      void
      _M_length(size_type __length)
      { _M_string_length = __length; }
      pointer
      _M_data() const
      { return _M_dataplus._M_p; }
      pointer
      _M_local_data()
      {
 return std::pointer_traits<pointer>::pointer_to(*_M_local_buf);
      }
      const_pointer
      _M_local_data() const
      {
 return std::pointer_traits<const_pointer>::pointer_to(*_M_local_buf);
      }
      void
      _M_capacity(size_type __capacity)
      { _M_allocated_capacity = __capacity; }
      void
      _M_set_length(size_type __n)
      {
 _M_length(__n);
 traits_type::assign(_M_data()[__n], _CharT());
      }
      bool
      _M_is_local() const
      { return _M_data() == _M_local_data(); }
      pointer
      _M_create(size_type&, size_type);
      void
      _M_dispose()
      {
 if (!_M_is_local())
   _M_destroy(_M_allocated_capacity);
      }
      void
      _M_destroy(size_type __size) throw()
      { _Alloc_traits::deallocate(_M_get_allocator(), _M_data(), __size + 1); }
      template<typename _InIterator>
        void
        _M_construct_aux(_InIterator __beg, _InIterator __end,
    std::__false_type)
 {
          typedef typename iterator_traits<_InIterator>::iterator_category _Tag;
          _M_construct(__beg, __end, _Tag());
 }
      template<typename _Integer>
        void
        _M_construct_aux(_Integer __beg, _Integer __end, std::__true_type)
 { _M_construct_aux_2(static_cast<size_type>(__beg), __end); }
      void
      _M_construct_aux_2(size_type __req, _CharT __c)
      { _M_construct(__req, __c); }
      template<typename _InIterator>
        void
        _M_construct(_InIterator __beg, _InIterator __end)
 {
   typedef typename std::__is_integer<_InIterator>::__type _Integral;
   _M_construct_aux(__beg, __end, _Integral());
        }
      template<typename _InIterator>
        void
        _M_construct(_InIterator __beg, _InIterator __end,
       std::input_iterator_tag);
      template<typename _FwdIterator>
        void
        _M_construct(_FwdIterator __beg, _FwdIterator __end,
       std::forward_iterator_tag);
      void
      _M_construct(size_type __req, _CharT __c);
      allocator_type&
      _M_get_allocator()
      { return _M_dataplus; }
      const allocator_type&
      _M_get_allocator() const
      { return _M_dataplus; }
    private:
      size_type
      _M_check(size_type __pos, const char* __s) const
      {
 if (__pos > this->size())
   __throw_out_of_range_fmt(("%s: __pos (which is %zu) > " "this->size() (which is %zu)"),
       __s, __pos, this->size());
 return __pos;
      }
      void
      _M_check_length(size_type __n1, size_type __n2, const char* __s) const
      {
 if (this->max_size() - (this->size() - __n1) < __n2)
   __throw_length_error((__s));
      }
      size_type
      _M_limit(size_type __pos, size_type __off) const noexcept
      {
 const bool __testoff = __off < this->size() - __pos;
 return __testoff ? __off : this->size() - __pos;
      }
      bool
      _M_disjunct(const _CharT* __s) const noexcept
      {
 return (less<const _CharT*>()(__s, _M_data())
  || less<const _CharT*>()(_M_data() + this->size(), __s));
      }
      static void
      _S_copy(_CharT* __d, const _CharT* __s, size_type __n)
      {
 if (__n == 1)
   traits_type::assign(*__d, *__s);
 else
   traits_type::copy(__d, __s, __n);
      }
      static void
      _S_move(_CharT* __d, const _CharT* __s, size_type __n)
      {
 if (__n == 1)
   traits_type::assign(*__d, *__s);
 else
   traits_type::move(__d, __s, __n);
      }
      static void
      _S_assign(_CharT* __d, size_type __n, _CharT __c)
      {
 if (__n == 1)
   traits_type::assign(*__d, __c);
 else
   traits_type::assign(__d, __n, __c);
      }
      template<class _Iterator>
        static void
        _S_copy_chars(_CharT* __p, _Iterator __k1, _Iterator __k2)
        {
   for (; __k1 != __k2; ++__k1, (void)++__p)
     traits_type::assign(*__p, *__k1);
 }
      static void
      _S_copy_chars(_CharT* __p, iterator __k1, iterator __k2) noexcept
      { _S_copy_chars(__p, __k1.base(), __k2.base()); }
      static void
      _S_copy_chars(_CharT* __p, const_iterator __k1, const_iterator __k2)
      noexcept
      { _S_copy_chars(__p, __k1.base(), __k2.base()); }
      static void
      _S_copy_chars(_CharT* __p, _CharT* __k1, _CharT* __k2) noexcept
      { _S_copy(__p, __k1, __k2 - __k1); }
      static void
      _S_copy_chars(_CharT* __p, const _CharT* __k1, const _CharT* __k2)
      noexcept
      { _S_copy(__p, __k1, __k2 - __k1); }
      static int
      _S_compare(size_type __n1, size_type __n2) noexcept
      {
 const difference_type __d = difference_type(__n1 - __n2);
 if (__d > __gnu_cxx::__numeric_traits<int>::__max)
   return __gnu_cxx::__numeric_traits<int>::__max;
 else if (__d < __gnu_cxx::__numeric_traits<int>::__min)
   return __gnu_cxx::__numeric_traits<int>::__min;
 else
   return int(__d);
      }
      void
      _M_assign(const basic_string&);
      void
      _M_mutate(size_type __pos, size_type __len1, const _CharT* __s,
  size_type __len2);
      void
      _M_erase(size_type __pos, size_type __n);
    public:
      basic_string()
      noexcept(is_nothrow_default_constructible<_Alloc>::value)
      : _M_dataplus(_M_local_data())
      { _M_set_length(0); }
      explicit
      basic_string(const _Alloc& __a) noexcept
      : _M_dataplus(_M_local_data(), __a)
      { _M_set_length(0); }
      basic_string(const basic_string& __str)
      : _M_dataplus(_M_local_data(),
      _Alloc_traits::_S_select_on_copy(__str._M_get_allocator()))
      { _M_construct(__str._M_data(), __str._M_data() + __str.length()); }
      basic_string(const basic_string& __str, size_type __pos,
     const _Alloc& __a = _Alloc())
      : _M_dataplus(_M_local_data(), __a)
      {
 const _CharT* __start = __str._M_data()
   + __str._M_check(__pos, "basic_string::basic_string");
 _M_construct(__start, __start + __str._M_limit(__pos, npos));
      }
      basic_string(const basic_string& __str, size_type __pos,
     size_type __n)
      : _M_dataplus(_M_local_data())
      {
 const _CharT* __start = __str._M_data()
   + __str._M_check(__pos, "basic_string::basic_string");
 _M_construct(__start, __start + __str._M_limit(__pos, __n));
      }
      basic_string(const basic_string& __str, size_type __pos,
     size_type __n, const _Alloc& __a)
      : _M_dataplus(_M_local_data(), __a)
      {
 const _CharT* __start
   = __str._M_data() + __str._M_check(__pos, "string::string");
 _M_construct(__start, __start + __str._M_limit(__pos, __n));
      }
      basic_string(const _CharT* __s, size_type __n,
     const _Alloc& __a = _Alloc())
      : _M_dataplus(_M_local_data(), __a)
      { _M_construct(__s, __s + __n); }
      basic_string(const _CharT* __s, const _Alloc& __a = _Alloc())
      : _M_dataplus(_M_local_data(), __a)
      { _M_construct(__s, __s ? __s + traits_type::length(__s) : __s+npos); }
      basic_string(size_type __n, _CharT __c, const _Alloc& __a = _Alloc())
      : _M_dataplus(_M_local_data(), __a)
      { _M_construct(__n, __c); }
      basic_string(basic_string&& __str) noexcept
      : _M_dataplus(_M_local_data(), std::move(__str._M_get_allocator()))
      {
 if (__str._M_is_local())
   {
     traits_type::copy(_M_local_buf, __str._M_local_buf,
         _S_local_capacity + 1);
   }
 else
   {
     _M_data(__str._M_data());
     _M_capacity(__str._M_allocated_capacity);
   }
 _M_length(__str.length());
 __str._M_data(__str._M_local_data());
 __str._M_set_length(0);
      }
      basic_string(initializer_list<_CharT> __l, const _Alloc& __a = _Alloc())
      : _M_dataplus(_M_local_data(), __a)
      { _M_construct(__l.begin(), __l.end()); }
      basic_string(const basic_string& __str, const _Alloc& __a)
      : _M_dataplus(_M_local_data(), __a)
      { _M_construct(__str.begin(), __str.end()); }
      basic_string(basic_string&& __str, const _Alloc& __a)
      noexcept(_Alloc_traits::_S_always_equal())
      : _M_dataplus(_M_local_data(), __a)
      {
 if (__str._M_is_local())
   {
     traits_type::copy(_M_local_buf, __str._M_local_buf,
         _S_local_capacity + 1);
     _M_length(__str.length());
     __str._M_set_length(0);
   }
 else if (_Alloc_traits::_S_always_equal()
     || __str.get_allocator() == __a)
   {
     _M_data(__str._M_data());
     _M_length(__str.length());
     _M_capacity(__str._M_allocated_capacity);
     __str._M_data(__str._M_local_buf);
     __str._M_set_length(0);
   }
 else
   _M_construct(__str.begin(), __str.end());
      }
      template<typename _InputIterator,
        typename = std::_RequireInputIter<_InputIterator>>
        basic_string(_InputIterator __beg, _InputIterator __end,
       const _Alloc& __a = _Alloc())
 : _M_dataplus(_M_local_data(), __a)
 { _M_construct(__beg, __end); }
      ~basic_string()
      { _M_dispose(); }
      basic_string&
      operator=(const basic_string& __str)
      {
 if (_Alloc_traits::_S_propagate_on_copy_assign())
   {
     if (!_Alloc_traits::_S_always_equal() && !_M_is_local()
  && _M_get_allocator() != __str._M_get_allocator())
       {
  if (__str.size() <= _S_local_capacity)
    {
      _M_destroy(_M_allocated_capacity);
      _M_data(_M_local_data());
      _M_set_length(0);
    }
  else
    {
      const auto __len = __str.size();
      auto __alloc = __str._M_get_allocator();
      auto __ptr = _Alloc_traits::allocate(__alloc, __len + 1);
      _M_destroy(_M_allocated_capacity);
      _M_data(__ptr);
      _M_capacity(__len);
      _M_set_length(__len);
    }
       }
     std::__alloc_on_copy(_M_get_allocator(), __str._M_get_allocator());
   }
 return this->assign(__str);
      }
      basic_string&
      operator=(const _CharT* __s)
      { return this->assign(__s); }
      basic_string&
      operator=(_CharT __c)
      {
 this->assign(1, __c);
 return *this;
      }
      basic_string&
      operator=(basic_string&& __str)
      noexcept(_Alloc_traits::_S_nothrow_move())
      {
 if (!_M_is_local() && _Alloc_traits::_S_propagate_on_move_assign()
     && !_Alloc_traits::_S_always_equal()
     && _M_get_allocator() != __str._M_get_allocator())
   {
     _M_destroy(_M_allocated_capacity);
     _M_data(_M_local_data());
     _M_set_length(0);
   }
 std::__alloc_on_move(_M_get_allocator(), __str._M_get_allocator());
 if (!__str._M_is_local()
     && (_Alloc_traits::_S_propagate_on_move_assign()
       || _Alloc_traits::_S_always_equal()))
   {
     pointer __data = nullptr;
     size_type __capacity;
     if (!_M_is_local())
       {
  if (_Alloc_traits::_S_always_equal())
    {
      __data = _M_data();
      __capacity = _M_allocated_capacity;
    }
  else
    _M_destroy(_M_allocated_capacity);
       }
     _M_data(__str._M_data());
     _M_length(__str.length());
     _M_capacity(__str._M_allocated_capacity);
     if (__data)
       {
  __str._M_data(__data);
  __str._M_capacity(__capacity);
       }
     else
       __str._M_data(__str._M_local_buf);
   }
 else
     assign(__str);
 __str.clear();
 return *this;
      }
      basic_string&
      operator=(initializer_list<_CharT> __l)
      {
 this->assign(__l.begin(), __l.size());
 return *this;
      }
      iterator
      begin() noexcept
      { return iterator(_M_data()); }
      const_iterator
      begin() const noexcept
      { return const_iterator(_M_data()); }
      iterator
      end() noexcept
      { return iterator(_M_data() + this->size()); }
      const_iterator
      end() const noexcept
      { return const_iterator(_M_data() + this->size()); }
      reverse_iterator
      rbegin() noexcept
      { return reverse_iterator(this->end()); }
      const_reverse_iterator
      rbegin() const noexcept
      { return const_reverse_iterator(this->end()); }
      reverse_iterator
      rend() noexcept
      { return reverse_iterator(this->begin()); }
      const_reverse_iterator
      rend() const noexcept
      { return const_reverse_iterator(this->begin()); }
      const_iterator
      cbegin() const noexcept
      { return const_iterator(this->_M_data()); }
      const_iterator
      cend() const noexcept
      { return const_iterator(this->_M_data() + this->size()); }
      const_reverse_iterator
      crbegin() const noexcept
      { return const_reverse_iterator(this->end()); }
      const_reverse_iterator
      crend() const noexcept
      { return const_reverse_iterator(this->begin()); }
    public:
      size_type
      size() const noexcept
      { return _M_string_length; }
      size_type
      length() const noexcept
      { return _M_string_length; }
      size_type
      max_size() const noexcept
      { return (_Alloc_traits::max_size(_M_get_allocator()) - 1) / 2; }
      void
      resize(size_type __n, _CharT __c);
      void
      resize(size_type __n)
      { this->resize(__n, _CharT()); }
      void
      shrink_to_fit() noexcept
      {
 if (capacity() > size())
   {
     try
       { reserve(0); }
     catch(...)
       { }
   }
      }
      size_type
      capacity() const noexcept
      {
 return _M_is_local() ? size_type(_S_local_capacity)
                      : _M_allocated_capacity;
      }
      void
      reserve(size_type __res_arg = 0);
      void
      clear() noexcept
      { _M_set_length(0); }
      bool
      empty() const noexcept
      { return this->size() == 0; }
      const_reference
      operator[] (size_type __pos) const noexcept
      {
 ;
 return _M_data()[__pos];
      }
      reference
      operator[](size_type __pos)
      {
 ;
 ;
 return _M_data()[__pos];
      }
      const_reference
      at(size_type __n) const
      {
 if (__n >= this->size())
   __throw_out_of_range_fmt(("basic_string::at: __n " "(which is %zu) >= this->size() " "(which is %zu)"),
       __n, this->size());
 return _M_data()[__n];
      }
      reference
      at(size_type __n)
      {
 if (__n >= size())
   __throw_out_of_range_fmt(("basic_string::at: __n " "(which is %zu) >= this->size() " "(which is %zu)"),
       __n, this->size());
 return _M_data()[__n];
      }
      reference
      front() noexcept
      {
 ;
 return operator[](0);
      }
      const_reference
      front() const noexcept
      {
 ;
 return operator[](0);
      }
      reference
      back() noexcept
      {
 ;
 return operator[](this->size() - 1);
      }
      const_reference
      back() const noexcept
      {
 ;
 return operator[](this->size() - 1);
      }
      basic_string&
      operator+=(const basic_string& __str)
      { return this->append(__str); }
      basic_string&
      operator+=(const _CharT* __s)
      { return this->append(__s); }
      basic_string&
      operator+=(_CharT __c)
      {
 this->push_back(__c);
 return *this;
      }
      basic_string&
      operator+=(initializer_list<_CharT> __l)
      { return this->append(__l.begin(), __l.size()); }
      basic_string&
      append(const basic_string& __str)
      { return _M_append(__str._M_data(), __str.size()); }
      basic_string&
      append(const basic_string& __str, size_type __pos, size_type __n)
      { return _M_append(__str._M_data()
    + __str._M_check(__pos, "basic_string::append"),
    __str._M_limit(__pos, __n)); }
      basic_string&
      append(const _CharT* __s, size_type __n)
      {
 ;
 _M_check_length(size_type(0), __n, "basic_string::append");
 return _M_append(__s, __n);
      }
      basic_string&
      append(const _CharT* __s)
      {
 ;
 const size_type __n = traits_type::length(__s);
 _M_check_length(size_type(0), __n, "basic_string::append");
 return _M_append(__s, __n);
      }
      basic_string&
      append(size_type __n, _CharT __c)
      { return _M_replace_aux(this->size(), size_type(0), __n, __c); }
      basic_string&
      append(initializer_list<_CharT> __l)
      { return this->append(__l.begin(), __l.size()); }
      template<class _InputIterator,
        typename = std::_RequireInputIter<_InputIterator>>
        basic_string&
        append(_InputIterator __first, _InputIterator __last)
        { return this->replace(end(), end(), __first, __last); }
      void
      push_back(_CharT __c)
      {
 const size_type __size = this->size();
 if (__size + 1 > this->capacity())
   this->_M_mutate(__size, size_type(0), 0, size_type(1));
 traits_type::assign(this->_M_data()[__size], __c);
 this->_M_set_length(__size + 1);
      }
      basic_string&
      assign(const basic_string& __str)
      {
 this->_M_assign(__str);
 return *this;
      }
      basic_string&
      assign(basic_string&& __str)
      noexcept(_Alloc_traits::_S_nothrow_move())
      {
 return *this = std::move(__str);
      }
      basic_string&
      assign(const basic_string& __str, size_type __pos, size_type __n)
      { return _M_replace(size_type(0), this->size(), __str._M_data()
     + __str._M_check(__pos, "basic_string::assign"),
     __str._M_limit(__pos, __n)); }
      basic_string&
      assign(const _CharT* __s, size_type __n)
      {
 ;
 return _M_replace(size_type(0), this->size(), __s, __n);
      }
      basic_string&
      assign(const _CharT* __s)
      {
 ;
 return _M_replace(size_type(0), this->size(), __s,
     traits_type::length(__s));
      }
      basic_string&
      assign(size_type __n, _CharT __c)
      { return _M_replace_aux(size_type(0), this->size(), __n, __c); }
      template<class _InputIterator,
        typename = std::_RequireInputIter<_InputIterator>>
        basic_string&
        assign(_InputIterator __first, _InputIterator __last)
        { return this->replace(begin(), end(), __first, __last); }
      basic_string&
      assign(initializer_list<_CharT> __l)
      { return this->assign(__l.begin(), __l.size()); }
      iterator
      insert(const_iterator __p, size_type __n, _CharT __c)
      {
 ;
 const size_type __pos = __p - begin();
 this->replace(__p, __p, __n, __c);
 return iterator(this->_M_data() + __pos);
      }
      template<class _InputIterator,
        typename = std::_RequireInputIter<_InputIterator>>
 iterator
        insert(const_iterator __p, _InputIterator __beg, _InputIterator __end)
        {
   ;
   const size_type __pos = __p - begin();
   this->replace(__p, __p, __beg, __end);
   return iterator(this->_M_data() + __pos);
 }
      void
      insert(iterator __p, initializer_list<_CharT> __l)
      {
 ;
 this->insert(__p - begin(), __l.begin(), __l.size());
      }
      basic_string&
      insert(size_type __pos1, const basic_string& __str)
      { return this->replace(__pos1, size_type(0),
        __str._M_data(), __str.size()); }
      basic_string&
      insert(size_type __pos1, const basic_string& __str,
      size_type __pos2, size_type __n)
      { return this->replace(__pos1, size_type(0), __str._M_data()
        + __str._M_check(__pos2, "basic_string::insert"),
        __str._M_limit(__pos2, __n)); }
      basic_string&
      insert(size_type __pos, const _CharT* __s, size_type __n)
      { return this->replace(__pos, size_type(0), __s, __n); }
      basic_string&
      insert(size_type __pos, const _CharT* __s)
      {
 ;
 return this->replace(__pos, size_type(0), __s,
        traits_type::length(__s));
      }
      basic_string&
      insert(size_type __pos, size_type __n, _CharT __c)
      { return _M_replace_aux(_M_check(__pos, "basic_string::insert"),
         size_type(0), __n, __c); }
      iterator
      insert(__const_iterator __p, _CharT __c)
      {
 ;
 const size_type __pos = __p - begin();
 _M_replace_aux(__pos, size_type(0), size_type(1), __c);
 return iterator(_M_data() + __pos);
      }
      basic_string&
      erase(size_type __pos = 0, size_type __n = npos)
      {
 _M_check(__pos, "basic_string::erase");
 if (__n == npos)
   this->_M_set_length(__pos);
 else if (__n != 0)
   this->_M_erase(__pos, _M_limit(__pos, __n));
 return *this;
      }
      iterator
      erase(__const_iterator __position)
      {
 ;
 const size_type __pos = __position - begin();
 this->_M_erase(__pos, size_type(1));
 return iterator(_M_data() + __pos);
      }
      iterator
      erase(__const_iterator __first, __const_iterator __last)
      {
 ;
        const size_type __pos = __first - begin();
 if (__last == end())
   this->_M_set_length(__pos);
 else
   this->_M_erase(__pos, __last - __first);
 return iterator(this->_M_data() + __pos);
      }
      void
      pop_back() noexcept
      {
 ;
 _M_erase(size() - 1, 1);
      }
      basic_string&
      replace(size_type __pos, size_type __n, const basic_string& __str)
      { return this->replace(__pos, __n, __str._M_data(), __str.size()); }
      basic_string&
      replace(size_type __pos1, size_type __n1, const basic_string& __str,
       size_type __pos2, size_type __n2)
      { return this->replace(__pos1, __n1, __str._M_data()
        + __str._M_check(__pos2, "basic_string::replace"),
        __str._M_limit(__pos2, __n2)); }
      basic_string&
      replace(size_type __pos, size_type __n1, const _CharT* __s,
       size_type __n2)
      {
 ;
 return _M_replace(_M_check(__pos, "basic_string::replace"),
     _M_limit(__pos, __n1), __s, __n2);
      }
      basic_string&
      replace(size_type __pos, size_type __n1, const _CharT* __s)
      {
 ;
 return this->replace(__pos, __n1, __s, traits_type::length(__s));
      }
      basic_string&
      replace(size_type __pos, size_type __n1, size_type __n2, _CharT __c)
      { return _M_replace_aux(_M_check(__pos, "basic_string::replace"),
         _M_limit(__pos, __n1), __n2, __c); }
      basic_string&
      replace(__const_iterator __i1, __const_iterator __i2,
       const basic_string& __str)
      { return this->replace(__i1, __i2, __str._M_data(), __str.size()); }
      basic_string&
      replace(__const_iterator __i1, __const_iterator __i2,
       const _CharT* __s, size_type __n)
      {
 ;
 return this->replace(__i1 - begin(), __i2 - __i1, __s, __n);
      }
      basic_string&
      replace(__const_iterator __i1, __const_iterator __i2, const _CharT* __s)
      {
 ;
 return this->replace(__i1, __i2, __s, traits_type::length(__s));
      }
      basic_string&
      replace(__const_iterator __i1, __const_iterator __i2, size_type __n,
       _CharT __c)
      {
 ;
 return _M_replace_aux(__i1 - begin(), __i2 - __i1, __n, __c);
      }
      template<class _InputIterator,
        typename = std::_RequireInputIter<_InputIterator>>
        basic_string&
        replace(const_iterator __i1, const_iterator __i2,
  _InputIterator __k1, _InputIterator __k2)
        {
   ;
   ;
   return this->_M_replace_dispatch(__i1, __i2, __k1, __k2,
        std::__false_type());
 }
      basic_string&
      replace(__const_iterator __i1, __const_iterator __i2,
       _CharT* __k1, _CharT* __k2)
      {
 ;
 ;
 return this->replace(__i1 - begin(), __i2 - __i1,
        __k1, __k2 - __k1);
      }
      basic_string&
      replace(__const_iterator __i1, __const_iterator __i2,
       const _CharT* __k1, const _CharT* __k2)
      {
 ;
 ;
 return this->replace(__i1 - begin(), __i2 - __i1,
        __k1, __k2 - __k1);
      }
      basic_string&
      replace(__const_iterator __i1, __const_iterator __i2,
       iterator __k1, iterator __k2)
      {
 ;
 ;
 return this->replace(__i1 - begin(), __i2 - __i1,
        __k1.base(), __k2 - __k1);
      }
      basic_string&
      replace(__const_iterator __i1, __const_iterator __i2,
       const_iterator __k1, const_iterator __k2)
      {
 ;
 ;
 return this->replace(__i1 - begin(), __i2 - __i1,
        __k1.base(), __k2 - __k1);
      }
      basic_string& replace(const_iterator __i1, const_iterator __i2,
       initializer_list<_CharT> __l)
      { return this->replace(__i1, __i2, __l.begin(), __l.size()); }
    private:
      template<class _Integer>
 basic_string&
 _M_replace_dispatch(const_iterator __i1, const_iterator __i2,
       _Integer __n, _Integer __val, __true_type)
        { return _M_replace_aux(__i1 - begin(), __i2 - __i1, __n, __val); }
      template<class _InputIterator>
 basic_string&
 _M_replace_dispatch(const_iterator __i1, const_iterator __i2,
       _InputIterator __k1, _InputIterator __k2,
       __false_type);
      basic_string&
      _M_replace_aux(size_type __pos1, size_type __n1, size_type __n2,
       _CharT __c);
      basic_string&
      _M_replace(size_type __pos, size_type __len1, const _CharT* __s,
   const size_type __len2);
      basic_string&
      _M_append(const _CharT* __s, size_type __n);
    public:
      size_type
      copy(_CharT* __s, size_type __n, size_type __pos = 0) const;
      void
      swap(basic_string& __s) noexcept;
      const _CharT*
      c_str() const noexcept
      { return _M_data(); }
      const _CharT*
      data() const noexcept
      { return _M_data(); }
      allocator_type
      get_allocator() const noexcept
      { return _M_get_allocator(); }
      size_type
      find(const _CharT* __s, size_type __pos, size_type __n) const
      noexcept;
      size_type
      find(const basic_string& __str, size_type __pos = 0) const
      noexcept
      { return this->find(__str.data(), __pos, __str.size()); }
      size_type
      find(const _CharT* __s, size_type __pos = 0) const noexcept
      {
 ;
 return this->find(__s, __pos, traits_type::length(__s));
      }
      size_type
      find(_CharT __c, size_type __pos = 0) const noexcept;
      size_type
      rfind(const basic_string& __str, size_type __pos = npos) const
      noexcept
      { return this->rfind(__str.data(), __pos, __str.size()); }
      size_type
      rfind(const _CharT* __s, size_type __pos, size_type __n) const
      noexcept;
      size_type
      rfind(const _CharT* __s, size_type __pos = npos) const
      {
 ;
 return this->rfind(__s, __pos, traits_type::length(__s));
      }
      size_type
      rfind(_CharT __c, size_type __pos = npos) const noexcept;
      size_type
      find_first_of(const basic_string& __str, size_type __pos = 0) const
      noexcept
      { return this->find_first_of(__str.data(), __pos, __str.size()); }
      size_type
      find_first_of(const _CharT* __s, size_type __pos, size_type __n) const
      noexcept;
      size_type
      find_first_of(const _CharT* __s, size_type __pos = 0) const
      noexcept
      {
 ;
 return this->find_first_of(__s, __pos, traits_type::length(__s));
      }
      size_type
      find_first_of(_CharT __c, size_type __pos = 0) const noexcept
      { return this->find(__c, __pos); }
      size_type
      find_last_of(const basic_string& __str, size_type __pos = npos) const
      noexcept
      { return this->find_last_of(__str.data(), __pos, __str.size()); }
      size_type
      find_last_of(const _CharT* __s, size_type __pos, size_type __n) const
      noexcept;
      size_type
      find_last_of(const _CharT* __s, size_type __pos = npos) const
      noexcept
      {
 ;
 return this->find_last_of(__s, __pos, traits_type::length(__s));
      }
      size_type
      find_last_of(_CharT __c, size_type __pos = npos) const noexcept
      { return this->rfind(__c, __pos); }
      size_type
      find_first_not_of(const basic_string& __str, size_type __pos = 0) const
      noexcept
      { return this->find_first_not_of(__str.data(), __pos, __str.size()); }
      size_type
      find_first_not_of(const _CharT* __s, size_type __pos,
   size_type __n) const noexcept;
      size_type
      find_first_not_of(const _CharT* __s, size_type __pos = 0) const
      noexcept
      {
 ;
 return this->find_first_not_of(__s, __pos, traits_type::length(__s));
      }
      size_type
      find_first_not_of(_CharT __c, size_type __pos = 0) const
      noexcept;
      size_type
      find_last_not_of(const basic_string& __str, size_type __pos = npos) const
      noexcept
      { return this->find_last_not_of(__str.data(), __pos, __str.size()); }
      size_type
      find_last_not_of(const _CharT* __s, size_type __pos,
         size_type __n) const noexcept;
      size_type
      find_last_not_of(const _CharT* __s, size_type __pos = npos) const
      noexcept
      {
 ;
 return this->find_last_not_of(__s, __pos, traits_type::length(__s));
      }
      size_type
      find_last_not_of(_CharT __c, size_type __pos = npos) const
      noexcept;
      basic_string
      substr(size_type __pos = 0, size_type __n = npos) const
      { return basic_string(*this,
       _M_check(__pos, "basic_string::substr"), __n); }
      int
      compare(const basic_string& __str) const
      {
 const size_type __size = this->size();
 const size_type __osize = __str.size();
 const size_type __len = std::min(__size, __osize);
 int __r = traits_type::compare(_M_data(), __str.data(), __len);
 if (!__r)
   __r = _S_compare(__size, __osize);
 return __r;
      }
      int
      compare(size_type __pos, size_type __n, const basic_string& __str) const;
      int
      compare(size_type __pos1, size_type __n1, const basic_string& __str,
       size_type __pos2, size_type __n2) const;
      int
      compare(const _CharT* __s) const noexcept;
      int
      compare(size_type __pos, size_type __n1, const _CharT* __s) const;
      int
      compare(size_type __pos, size_type __n1, const _CharT* __s,
       size_type __n2) const;
      template<typename, typename, typename> friend class basic_stringbuf;
    };
}
  template<typename _CharT, typename _Traits, typename _Alloc>
    basic_string<_CharT, _Traits, _Alloc>
    operator+(const basic_string<_CharT, _Traits, _Alloc>& __lhs,
       const basic_string<_CharT, _Traits, _Alloc>& __rhs)
    {
      basic_string<_CharT, _Traits, _Alloc> __str(__lhs);
      __str.append(__rhs);
      return __str;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    basic_string<_CharT,_Traits,_Alloc>
    operator+(const _CharT* __lhs,
       const basic_string<_CharT,_Traits,_Alloc>& __rhs);
  template<typename _CharT, typename _Traits, typename _Alloc>
    basic_string<_CharT,_Traits,_Alloc>
    operator+(_CharT __lhs, const basic_string<_CharT,_Traits,_Alloc>& __rhs);
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline basic_string<_CharT, _Traits, _Alloc>
    operator+(const basic_string<_CharT, _Traits, _Alloc>& __lhs,
       const _CharT* __rhs)
    {
      basic_string<_CharT, _Traits, _Alloc> __str(__lhs);
      __str.append(__rhs);
      return __str;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline basic_string<_CharT, _Traits, _Alloc>
    operator+(const basic_string<_CharT, _Traits, _Alloc>& __lhs, _CharT __rhs)
    {
      typedef basic_string<_CharT, _Traits, _Alloc> __string_type;
      typedef typename __string_type::size_type __size_type;
      __string_type __str(__lhs);
      __str.append(__size_type(1), __rhs);
      return __str;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline basic_string<_CharT, _Traits, _Alloc>
    operator+(basic_string<_CharT, _Traits, _Alloc>&& __lhs,
       const basic_string<_CharT, _Traits, _Alloc>& __rhs)
    { return std::move(__lhs.append(__rhs)); }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline basic_string<_CharT, _Traits, _Alloc>
    operator+(const basic_string<_CharT, _Traits, _Alloc>& __lhs,
       basic_string<_CharT, _Traits, _Alloc>&& __rhs)
    { return std::move(__rhs.insert(0, __lhs)); }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline basic_string<_CharT, _Traits, _Alloc>
    operator+(basic_string<_CharT, _Traits, _Alloc>&& __lhs,
       basic_string<_CharT, _Traits, _Alloc>&& __rhs)
    {
      const auto __size = __lhs.size() + __rhs.size();
      const bool __cond = (__size > __lhs.capacity()
      && __size <= __rhs.capacity());
      return __cond ? std::move(__rhs.insert(0, __lhs))
             : std::move(__lhs.append(__rhs));
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline basic_string<_CharT, _Traits, _Alloc>
    operator+(const _CharT* __lhs,
       basic_string<_CharT, _Traits, _Alloc>&& __rhs)
    { return std::move(__rhs.insert(0, __lhs)); }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline basic_string<_CharT, _Traits, _Alloc>
    operator+(_CharT __lhs,
       basic_string<_CharT, _Traits, _Alloc>&& __rhs)
    { return std::move(__rhs.insert(0, 1, __lhs)); }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline basic_string<_CharT, _Traits, _Alloc>
    operator+(basic_string<_CharT, _Traits, _Alloc>&& __lhs,
       const _CharT* __rhs)
    { return std::move(__lhs.append(__rhs)); }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline basic_string<_CharT, _Traits, _Alloc>
    operator+(basic_string<_CharT, _Traits, _Alloc>&& __lhs,
       _CharT __rhs)
    { return std::move(__lhs.append(1, __rhs)); }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline bool
    operator==(const basic_string<_CharT, _Traits, _Alloc>& __lhs,
        const basic_string<_CharT, _Traits, _Alloc>& __rhs)
    noexcept
    { return __lhs.compare(__rhs) == 0; }
  template<typename _CharT>
    inline
    typename __gnu_cxx::__enable_if<__is_char<_CharT>::__value, bool>::__type
    operator==(const basic_string<_CharT>& __lhs,
        const basic_string<_CharT>& __rhs) noexcept
    { return (__lhs.size() == __rhs.size()
       && !std::char_traits<_CharT>::compare(__lhs.data(), __rhs.data(),
          __lhs.size())); }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline bool
    operator==(const _CharT* __lhs,
        const basic_string<_CharT, _Traits, _Alloc>& __rhs)
    { return __rhs.compare(__lhs) == 0; }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline bool
    operator==(const basic_string<_CharT, _Traits, _Alloc>& __lhs,
        const _CharT* __rhs)
    { return __lhs.compare(__rhs) == 0; }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline bool
    operator!=(const basic_string<_CharT, _Traits, _Alloc>& __lhs,
        const basic_string<_CharT, _Traits, _Alloc>& __rhs)
    noexcept
    { return !(__lhs == __rhs); }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline bool
    operator!=(const _CharT* __lhs,
        const basic_string<_CharT, _Traits, _Alloc>& __rhs)
    { return !(__lhs == __rhs); }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline bool
    operator!=(const basic_string<_CharT, _Traits, _Alloc>& __lhs,
        const _CharT* __rhs)
    { return !(__lhs == __rhs); }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline bool
    operator<(const basic_string<_CharT, _Traits, _Alloc>& __lhs,
       const basic_string<_CharT, _Traits, _Alloc>& __rhs)
    noexcept
    { return __lhs.compare(__rhs) < 0; }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline bool
    operator<(const basic_string<_CharT, _Traits, _Alloc>& __lhs,
       const _CharT* __rhs)
    { return __lhs.compare(__rhs) < 0; }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline bool
    operator<(const _CharT* __lhs,
       const basic_string<_CharT, _Traits, _Alloc>& __rhs)
    { return __rhs.compare(__lhs) > 0; }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline bool
    operator>(const basic_string<_CharT, _Traits, _Alloc>& __lhs,
       const basic_string<_CharT, _Traits, _Alloc>& __rhs)
    noexcept
    { return __lhs.compare(__rhs) > 0; }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline bool
    operator>(const basic_string<_CharT, _Traits, _Alloc>& __lhs,
       const _CharT* __rhs)
    { return __lhs.compare(__rhs) > 0; }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline bool
    operator>(const _CharT* __lhs,
       const basic_string<_CharT, _Traits, _Alloc>& __rhs)
    { return __rhs.compare(__lhs) < 0; }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline bool
    operator<=(const basic_string<_CharT, _Traits, _Alloc>& __lhs,
        const basic_string<_CharT, _Traits, _Alloc>& __rhs)
    noexcept
    { return __lhs.compare(__rhs) <= 0; }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline bool
    operator<=(const basic_string<_CharT, _Traits, _Alloc>& __lhs,
        const _CharT* __rhs)
    { return __lhs.compare(__rhs) <= 0; }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline bool
    operator<=(const _CharT* __lhs,
        const basic_string<_CharT, _Traits, _Alloc>& __rhs)
    { return __rhs.compare(__lhs) >= 0; }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline bool
    operator>=(const basic_string<_CharT, _Traits, _Alloc>& __lhs,
        const basic_string<_CharT, _Traits, _Alloc>& __rhs)
    noexcept
    { return __lhs.compare(__rhs) >= 0; }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline bool
    operator>=(const basic_string<_CharT, _Traits, _Alloc>& __lhs,
        const _CharT* __rhs)
    { return __lhs.compare(__rhs) >= 0; }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline bool
    operator>=(const _CharT* __lhs,
      const basic_string<_CharT, _Traits, _Alloc>& __rhs)
    { return __rhs.compare(__lhs) <= 0; }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline void
    swap(basic_string<_CharT, _Traits, _Alloc>& __lhs,
  basic_string<_CharT, _Traits, _Alloc>& __rhs)
    noexcept(noexcept(__lhs.swap(__rhs)))
    { __lhs.swap(__rhs); }
  template<typename _CharT, typename _Traits, typename _Alloc>
    basic_istream<_CharT, _Traits>&
    operator>>(basic_istream<_CharT, _Traits>& __is,
        basic_string<_CharT, _Traits, _Alloc>& __str);
  template<>
    basic_istream<char>&
    operator>>(basic_istream<char>& __is, basic_string<char>& __str);
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline basic_ostream<_CharT, _Traits>&
    operator<<(basic_ostream<_CharT, _Traits>& __os,
        const basic_string<_CharT, _Traits, _Alloc>& __str)
    {
      return __ostream_insert(__os, __str.data(), __str.size());
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    basic_istream<_CharT, _Traits>&
    getline(basic_istream<_CharT, _Traits>& __is,
     basic_string<_CharT, _Traits, _Alloc>& __str, _CharT __delim);
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline basic_istream<_CharT, _Traits>&
    getline(basic_istream<_CharT, _Traits>& __is,
     basic_string<_CharT, _Traits, _Alloc>& __str)
    { return std::getline(__is, __str, __is.widen('\n')); }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline basic_istream<_CharT, _Traits>&
    getline(basic_istream<_CharT, _Traits>&& __is,
     basic_string<_CharT, _Traits, _Alloc>& __str, _CharT __delim)
    { return std::getline(__is, __str, __delim); }
  template<typename _CharT, typename _Traits, typename _Alloc>
    inline basic_istream<_CharT, _Traits>&
    getline(basic_istream<_CharT, _Traits>&& __is,
     basic_string<_CharT, _Traits, _Alloc>& __str)
    { return std::getline(__is, __str); }
  template<>
    basic_istream<char>&
    getline(basic_istream<char>& __in, basic_string<char>& __str,
     char __delim);
  template<>
    basic_istream<wchar_t>&
    getline(basic_istream<wchar_t>& __in, basic_string<wchar_t>& __str,
     wchar_t __delim);

}
       
       
#pragma pack(push,_CRT_PACKING)
extern "C" {
  typedef int (__attribute__((__cdecl__)) *_onexit_t)(void);
  typedef struct _div_t {
    int quot;
    int rem;
  } div_t;
  typedef struct _ldiv_t {
    long quot;
    long rem;
  } ldiv_t;
#pragma pack(4)
  typedef struct {
    unsigned char ld[10];
  } _LDOUBLE;
#pragma pack()
  typedef struct {
    double x;
  } _CRT_DOUBLE;
  typedef struct {
    float f;
  } _CRT_FLOAT;
       
  typedef struct {
    long double x;
  } _LONGDOUBLE;
       
#pragma pack(4)
  typedef struct {
    unsigned char ld12[12];
  } _LDBL12;
#pragma pack()
  typedef void (__attribute__((__cdecl__)) *_purecall_handler)(void);
  __attribute__ ((__dllimport__)) _purecall_handler __attribute__((__cdecl__)) _set_purecall_handler(_purecall_handler _Handler);
  __attribute__ ((__dllimport__)) _purecall_handler __attribute__((__cdecl__)) _get_purecall_handler(void);
  typedef void (__attribute__((__cdecl__)) *_invalid_parameter_handler)(const wchar_t *,const wchar_t *,const wchar_t *,unsigned int,uintptr_t);
  __attribute__ ((__dllimport__)) _invalid_parameter_handler __attribute__((__cdecl__)) _set_invalid_parameter_handler(_invalid_parameter_handler _Handler);
  __attribute__ ((__dllimport__)) _invalid_parameter_handler __attribute__((__cdecl__)) _get_invalid_parameter_handler(void);
  __attribute__ ((__dllimport__)) unsigned long *__attribute__((__cdecl__)) __doserrno(void);
  errno_t __attribute__((__cdecl__)) _set_doserrno(unsigned long _Value);
  errno_t __attribute__((__cdecl__)) _get_doserrno(unsigned long *_Value);
  extern __attribute__((dllimport)) char *_sys_errlist[1];
  extern __attribute__((dllimport)) int _sys_nerr;
  __attribute__ ((__dllimport__)) char ***__attribute__((__cdecl__)) __p___argv(void);
  __attribute__ ((__dllimport__)) int *__attribute__((__cdecl__)) __p__fmode(void);
  errno_t __attribute__((__cdecl__)) _get_pgmptr(char **_Value);
  errno_t __attribute__((__cdecl__)) _get_wpgmptr(wchar_t **_Value);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _set_fmode(int _Mode);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _get_fmode(int *_PMode);
  extern int * __imp___argc;
  extern char *** __imp___argv;
  extern wchar_t *** __imp___wargv;
  extern char *** __imp__environ;
  extern wchar_t *** __imp__wenviron;
  extern char ** __imp__pgmptr;
  extern wchar_t ** __imp__wpgmptr;
  extern unsigned int * __imp__osplatform;
  extern unsigned int * __imp__osver;
  extern unsigned int * __imp__winver;
  extern unsigned int * __imp__winmajor;
  extern unsigned int * __imp__winminor;
  errno_t __attribute__((__cdecl__)) _get_osplatform(unsigned int *_Value);
  errno_t __attribute__((__cdecl__)) _get_osver(unsigned int *_Value);
  errno_t __attribute__((__cdecl__)) _get_winver(unsigned int *_Value);
  errno_t __attribute__((__cdecl__)) _get_winmajor(unsigned int *_Value);
  errno_t __attribute__((__cdecl__)) _get_winminor(unsigned int *_Value);
  extern "C++" {
    template <typename _CountofType,size_t _SizeOfArray> char (*__countof_helper( _CountofType (&_Array)[_SizeOfArray]))[_SizeOfArray];
  }
  __attribute__ ((__dllimport__)) unsigned int __attribute__((__cdecl__)) _set_abort_behavior(unsigned int _Flags,unsigned int _Mask);
  int __attribute__((__cdecl__)) abs(int _X);
  long __attribute__((__cdecl__)) labs(long _X);
  __extension__ long long __attribute__((__cdecl__)) _abs64(long long);
  extern __inline__ __attribute__((__always_inline__,__gnu_inline__)) long long __attribute__((__cdecl__)) _abs64(long long x) {
    return __builtin_llabs(x);
  }
  int __attribute__((__cdecl__)) atexit(void (__attribute__((__cdecl__)) *)(void));
  double __attribute__((__cdecl__)) atof(const char *_String);
  double __attribute__((__cdecl__)) _atof_l(const char *_String,_locale_t _Locale);
  int __attribute__((__cdecl__)) atoi(const char *_Str);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _atoi_l(const char *_Str,_locale_t _Locale);
  long __attribute__((__cdecl__)) atol(const char *_Str);
  __attribute__ ((__dllimport__)) long __attribute__((__cdecl__)) _atol_l(const char *_Str,_locale_t _Locale);
  void *__attribute__((__cdecl__)) bsearch(const void *_Key,const void *_Base,size_t _NumOfElements,size_t _SizeOfElements,int (__attribute__((__cdecl__)) *_PtFuncCompare)(const void *,const void *));
  void __attribute__((__cdecl__)) qsort(void *_Base,size_t _NumOfElements,size_t _SizeOfElements,int (__attribute__((__cdecl__)) *_PtFuncCompare)(const void *,const void *));
  unsigned short __attribute__((__cdecl__)) _byteswap_ushort(unsigned short _Short);
  unsigned long __attribute__((__cdecl__)) _byteswap_ulong (unsigned long _Long);
  __extension__ unsigned long long __attribute__((__cdecl__)) _byteswap_uint64(unsigned long long _Int64);
  div_t __attribute__((__cdecl__)) div(int _Numerator,int _Denominator);
  char *__attribute__((__cdecl__)) getenv(const char *_VarName) ;
  __attribute__ ((__dllimport__)) char *__attribute__((__cdecl__)) _itoa(int _Value,char *_Dest,int _Radix);
  __extension__ __attribute__ ((__dllimport__)) char *__attribute__((__cdecl__)) _i64toa(long long _Val,char *_DstBuf,int _Radix) ;
  __extension__ __attribute__ ((__dllimport__)) char *__attribute__((__cdecl__)) _ui64toa(unsigned long long _Val,char *_DstBuf,int _Radix) ;
  __extension__ __attribute__ ((__dllimport__)) long long __attribute__((__cdecl__)) _atoi64(const char *_String);
  __extension__ __attribute__ ((__dllimport__)) long long __attribute__((__cdecl__)) _atoi64_l(const char *_String,_locale_t _Locale);
  __extension__ __attribute__ ((__dllimport__)) long long __attribute__((__cdecl__)) _strtoi64(const char *_String,char **_EndPtr,int _Radix);
  __extension__ __attribute__ ((__dllimport__)) long long __attribute__((__cdecl__)) _strtoi64_l(const char *_String,char **_EndPtr,int _Radix,_locale_t _Locale);
  __extension__ __attribute__ ((__dllimport__)) unsigned long long __attribute__((__cdecl__)) _strtoui64(const char *_String,char **_EndPtr,int _Radix);
  __extension__ __attribute__ ((__dllimport__)) unsigned long long __attribute__((__cdecl__)) _strtoui64_l(const char *_String,char **_EndPtr,int _Radix,_locale_t _Locale);
  ldiv_t __attribute__((__cdecl__)) ldiv(long _Numerator,long _Denominator);
  __attribute__ ((__dllimport__)) char *__attribute__((__cdecl__)) _ltoa(long _Value,char *_Dest,int _Radix) ;
  int __attribute__((__cdecl__)) mblen(const char *_Ch,size_t _MaxCount);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _mblen_l(const char *_Ch,size_t _MaxCount,_locale_t _Locale);
  __attribute__ ((__dllimport__)) size_t __attribute__((__cdecl__)) _mbstrlen(const char *_Str);
  __attribute__ ((__dllimport__)) size_t __attribute__((__cdecl__)) _mbstrlen_l(const char *_Str,_locale_t _Locale);
  __attribute__ ((__dllimport__)) size_t __attribute__((__cdecl__)) _mbstrnlen(const char *_Str,size_t _MaxCount);
  __attribute__ ((__dllimport__)) size_t __attribute__((__cdecl__)) _mbstrnlen_l(const char *_Str,size_t _MaxCount,_locale_t _Locale);
  int __attribute__((__cdecl__)) mbtowc(wchar_t * __restrict__ _DstCh,const char * __restrict__ _SrcCh,size_t _SrcSizeInBytes);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _mbtowc_l(wchar_t * __restrict__ _DstCh,const char * __restrict__ _SrcCh,size_t _SrcSizeInBytes,_locale_t _Locale);
  size_t __attribute__((__cdecl__)) mbstowcs(wchar_t * __restrict__ _Dest,const char * __restrict__ _Source,size_t _MaxCount);
  __attribute__ ((__dllimport__)) size_t __attribute__((__cdecl__)) _mbstowcs_l(wchar_t * __restrict__ _Dest,const char * __restrict__ _Source,size_t _MaxCount,_locale_t _Locale);
  int __attribute__((__cdecl__)) mkstemp(char *template_name);
  int __attribute__((__cdecl__)) rand(void);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _set_error_mode(int _Mode);
  void __attribute__((__cdecl__)) srand(unsigned int _Seed);
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
double __attribute__((__cdecl__)) __attribute__ ((__nothrow__)) strtod(const char * __restrict__ _Str,char ** __restrict__ _EndPtr)
{
  double __attribute__((__cdecl__)) __mingw_strtod (const char * __restrict__, char ** __restrict__);
  return __mingw_strtod( _Str, _EndPtr);
}
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
float __attribute__((__cdecl__)) __attribute__ ((__nothrow__)) strtof(const char * __restrict__ _Str,char ** __restrict__ _EndPtr)
{
  float __attribute__((__cdecl__)) __mingw_strtof (const char * __restrict__, char ** __restrict__);
  return __mingw_strtof( _Str, _EndPtr);
}
  long double __attribute__((__cdecl__)) __attribute__ ((__nothrow__)) strtold(const char * __restrict__ , char ** __restrict__ );
  extern double __attribute__((__cdecl__)) __attribute__ ((__nothrow__))
  __strtod (const char * __restrict__ , char ** __restrict__);
  float __attribute__((__cdecl__)) __mingw_strtof (const char * __restrict__, char ** __restrict__);
  double __attribute__((__cdecl__)) __mingw_strtod (const char * __restrict__, char ** __restrict__);
  long double __attribute__((__cdecl__)) __mingw_strtold(const char * __restrict__, char ** __restrict__);
  __attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) _strtod_l(const char * __restrict__ _Str,char ** __restrict__ _EndPtr,_locale_t _Locale);
  long __attribute__((__cdecl__)) strtol(const char * __restrict__ _Str,char ** __restrict__ _EndPtr,int _Radix);
  __attribute__ ((__dllimport__)) long __attribute__((__cdecl__)) _strtol_l(const char * __restrict__ _Str,char ** __restrict__ _EndPtr,int _Radix,_locale_t _Locale);
  unsigned long __attribute__((__cdecl__)) strtoul(const char * __restrict__ _Str,char ** __restrict__ _EndPtr,int _Radix);
  __attribute__ ((__dllimport__)) unsigned long __attribute__((__cdecl__)) _strtoul_l(const char * __restrict__ _Str,char ** __restrict__ _EndPtr,int _Radix,_locale_t _Locale);
  __attribute__ ((__dllimport__)) char *__attribute__((__cdecl__)) _ultoa(unsigned long _Value,char *_Dest,int _Radix) ;
  int __attribute__((__cdecl__)) wctomb(char *_MbCh,wchar_t _WCh) ;
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wctomb_l(char *_MbCh,wchar_t _WCh,_locale_t _Locale) ;
  size_t __attribute__((__cdecl__)) wcstombs(char * __restrict__ _Dest,const wchar_t * __restrict__ _Source,size_t _MaxCount) ;
  __attribute__ ((__dllimport__)) size_t __attribute__((__cdecl__)) _wcstombs_l(char * __restrict__ _Dest,const wchar_t * __restrict__ _Source,size_t _MaxCount,_locale_t _Locale) ;
  void *__attribute__((__cdecl__)) calloc(size_t _NumOfElements,size_t _SizeOfElements);
  void __attribute__((__cdecl__)) free(void *_Memory);
  void *__attribute__((__cdecl__)) malloc(size_t _Size);
  void *__attribute__((__cdecl__)) realloc(void *_Memory,size_t _NewSize);
  __attribute__ ((__dllimport__)) void *__attribute__((__cdecl__)) _recalloc(void *_Memory,size_t _Count,size_t _Size);
       
       
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _aligned_free(void *_Memory);
  __attribute__ ((__dllimport__)) void *__attribute__((__cdecl__)) _aligned_malloc(size_t _Size,size_t _Alignment);
       
       
  __attribute__ ((__dllimport__)) void *__attribute__((__cdecl__)) _aligned_offset_malloc(size_t _Size,size_t _Alignment,size_t _Offset);
  __attribute__ ((__dllimport__)) void *__attribute__((__cdecl__)) _aligned_realloc(void *_Memory,size_t _Size,size_t _Alignment);
  __attribute__ ((__dllimport__)) void *__attribute__((__cdecl__)) _aligned_recalloc(void *_Memory,size_t _Count,size_t _Size,size_t _Alignment);
  __attribute__ ((__dllimport__)) void *__attribute__((__cdecl__)) _aligned_offset_realloc(void *_Memory,size_t _Size,size_t _Alignment,size_t _Offset);
  __attribute__ ((__dllimport__)) void *__attribute__((__cdecl__)) _aligned_offset_recalloc(void *_Memory,size_t _Count,size_t _Size,size_t _Alignment,size_t _Offset);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _putenv(const char *_EnvString);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wputenv(const wchar_t *_EnvString);
  __attribute__ ((__dllimport__)) char *__attribute__((__cdecl__)) _fullpath(char *_FullPath,const char *_Path,size_t _SizeInBytes);
  __attribute__ ((__dllimport__)) char *__attribute__((__cdecl__)) _ecvt(double _Val,int _NumOfDigits,int *_PtDec,int *_PtSign) ;
  __attribute__ ((__dllimport__)) char *__attribute__((__cdecl__)) _fcvt(double _Val,int _NumOfDec,int *_PtDec,int *_PtSign) ;
  __attribute__ ((__dllimport__)) char *__attribute__((__cdecl__)) _gcvt(double _Val,int _NumOfDigits,char *_DstBuf) ;
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _atodbl(_CRT_DOUBLE *_Result,char *_Str);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _atoldbl(_LDOUBLE *_Result,char *_Str);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _atoflt(_CRT_FLOAT *_Result,char *_Str);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _atodbl_l(_CRT_DOUBLE *_Result,char *_Str,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _atoldbl_l(_LDOUBLE *_Result,char *_Str,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _atoflt_l(_CRT_FLOAT *_Result,char *_Str,_locale_t _Locale);
unsigned long __attribute__((__cdecl__)) _lrotl(unsigned long,int);
unsigned long __attribute__((__cdecl__)) _lrotr(unsigned long,int);
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _makepath(char *_Path,const char *_Drive,const char *_Dir,const char *_Filename,const char *_Ext);
  _onexit_t __attribute__((__cdecl__)) _onexit(_onexit_t _Func);
       
       
  __extension__ unsigned long long __attribute__((__cdecl__)) _rotl64(unsigned long long _Val,int _Shift);
  __extension__ unsigned long long __attribute__((__cdecl__)) _rotr64(unsigned long long Value,int Shift);
       
       
       
       
  unsigned int __attribute__((__cdecl__)) _rotr(unsigned int _Val,int _Shift);
  unsigned int __attribute__((__cdecl__)) _rotl(unsigned int _Val,int _Shift);
       
       
  __extension__ unsigned long long __attribute__((__cdecl__)) _rotr64(unsigned long long _Val,int _Shift);
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _searchenv(const char *_Filename,const char *_EnvVar,char *_ResultPath) ;
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _splitpath(const char *_FullPath,char *_Drive,char *_Dir,char *_Filename,char *_Ext) ;
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _swab(char *_Buf1,char *_Buf2,int _SizeInBytes);
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _beep(unsigned _Frequency,unsigned _Duration) __attribute__ ((__deprecated__));
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _seterrormode(int _Mode) __attribute__ ((__deprecated__));
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _sleep(unsigned long _Duration) __attribute__ ((__deprecated__));
  char *__attribute__((__cdecl__)) ecvt(double _Val,int _NumOfDigits,int *_PtDec,int *_PtSign) ;
  char *__attribute__((__cdecl__)) fcvt(double _Val,int _NumOfDec,int *_PtDec,int *_PtSign) ;
  char *__attribute__((__cdecl__)) gcvt(double _Val,int _NumOfDigits,char *_DstBuf) ;
  char *__attribute__((__cdecl__)) itoa(int _Val,char *_DstBuf,int _Radix) ;
  char *__attribute__((__cdecl__)) ltoa(long _Val,char *_DstBuf,int _Radix) ;
  int __attribute__((__cdecl__)) putenv(const char *_EnvString) ;
  void __attribute__((__cdecl__)) swab(char *_Buf1,char *_Buf2,int _SizeInBytes) ;
  char *__attribute__((__cdecl__)) ultoa(unsigned long _Val,char *_Dstbuf,int _Radix) ;
  _onexit_t __attribute__((__cdecl__)) onexit(_onexit_t _Func);
  typedef struct { __extension__ long long quot, rem; } lldiv_t;
  __extension__ lldiv_t __attribute__((__cdecl__)) lldiv(long long, long long);
  __extension__ long long __attribute__((__cdecl__)) llabs(long long);
  __extension__ long long __attribute__((__cdecl__)) strtoll(const char * __restrict__, char ** __restrict, int);
  __extension__ unsigned long long __attribute__((__cdecl__)) strtoull(const char * __restrict__, char ** __restrict__, int);
  __extension__ long long __attribute__((__cdecl__)) atoll (const char *);
  __extension__ long long __attribute__((__cdecl__)) wtoll (const wchar_t *);
  __extension__ char *__attribute__((__cdecl__)) lltoa (long long, char *, int);
  __extension__ char *__attribute__((__cdecl__)) ulltoa (unsigned long long , char *, int);
  __extension__ wchar_t *__attribute__((__cdecl__)) lltow (long long, wchar_t *, int);
  __extension__ wchar_t *__attribute__((__cdecl__)) ulltow (unsigned long long, wchar_t *, int);
}
#pragma pack(pop)
extern "C" {
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _dupenv_s(char **_PBuffer,size_t *_PBufferSizeInBytes,const char *_VarName);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _itoa_s(int _Value,char *_DstBuf,size_t _Size,int _Radix);
  extern "C++" { template <size_t __size> inline errno_t __attribute__((__cdecl__)) _itoa_s(int _Value, char (&_Dest)[__size], int _Radix) { return _itoa_s(_Value, _Dest, __size, _Radix); } }
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _i64toa_s(long long _Val,char *_DstBuf,size_t _Size,int _Radix);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _ui64toa_s(unsigned long long _Val,char *_DstBuf,size_t _Size,int _Radix);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _ltoa_s(long _Val,char *_DstBuf,size_t _Size,int _Radix);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) mbstowcs_s(size_t *_PtNumOfCharConverted,wchar_t *_DstBuf,size_t _SizeInWords,const char *_SrcBuf,size_t _MaxCount);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _mbstowcs_s_l(size_t *_PtNumOfCharConverted,wchar_t *_DstBuf,size_t _SizeInWords,const char *_SrcBuf,size_t _MaxCount,_locale_t _Locale);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _ultoa_s(unsigned long _Val,char *_DstBuf,size_t _Size,int _Radix);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wctomb_s_l(int *_SizeConverted,char *_MbCh,size_t _SizeInBytes,wchar_t _WCh,_locale_t _Locale);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) wcstombs_s(size_t *_PtNumOfCharConverted,char *_Dst,size_t _DstSizeInBytes,const wchar_t *_Src,size_t _MaxCountInBytes);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wcstombs_s_l(size_t *_PtNumOfCharConverted,char *_Dst,size_t _DstSizeInBytes,const wchar_t *_Src,size_t _MaxCountInBytes,_locale_t _Locale);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _ecvt_s(char *_DstBuf,size_t _Size,double _Val,int _NumOfDights,int *_PtDec,int *_PtSign);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _fcvt_s(char *_DstBuf,size_t _Size,double _Val,int _NumOfDec,int *_PtDec,int *_PtSign);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _gcvt_s(char *_DstBuf,size_t _Size,double _Val,int _NumOfDigits);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _makepath_s(char *_PathResult,size_t _Size,const char *_Drive,const char *_Dir,const char *_Filename,const char *_Ext);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _putenv_s(const char *_Name,const char *_Value);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _searchenv_s(const char *_Filename,const char *_EnvVar,char *_ResultPath,size_t _SizeInBytes);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _splitpath_s(const char *_FullPath,char *_Drive,size_t _DriveSize,char *_Dir,size_t _DirSize,char *_Filename,size_t _FilenameSize,char *_Ext,size_t _ExtSize);
  extern "C++" { template <size_t __drive_size, size_t __dir_size, size_t __name_size, size_t __ext_size> inline errno_t __attribute__((__cdecl__)) _splitpath_s(const char *_Dest, char (&__drive)[__drive_size], char (&__dir)[__dir_size], char (&__name)[__name_size], char (&__ext)[__ext_size]) { return _splitpath_s(_Dest, __drive, __drive_size, __dir, __dir_size, __name, __name_size, __ext, __ext_size); } }
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) qsort_s(void *_Base,size_t _NumOfElements,size_t _SizeOfElements,int (__attribute__((__cdecl__)) *_PtFuncCompare)(void *,const void *,const void *),void *_Context);
}
#pragma pack(push,_CRT_PACKING)
extern "C" {
  typedef struct _heapinfo {
    int *_pentry;
    size_t _size;
    int _useflag;
  } _HEAPINFO;
  extern unsigned int _amblksiz;
       
       
       
       
void * __mingw_aligned_malloc (size_t _Size, size_t _Alignment);
void __mingw_aligned_free (void *_Memory);
void * __mingw_aligned_offset_realloc (void *_Memory, size_t _Size, size_t _Alignment, size_t _Offset);
void * __mingw_aligned_realloc (void *_Memory, size_t _Size, size_t _Offset);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _resetstkoflw (void);
  __attribute__ ((__dllimport__)) unsigned long __attribute__((__cdecl__)) _set_malloc_crt_max_wait(unsigned long _NewValue);
  __attribute__ ((__dllimport__)) void *__attribute__((__cdecl__)) _expand(void *_Memory,size_t _NewSize);
  __attribute__ ((__dllimport__)) size_t __attribute__((__cdecl__)) _msize(void *_Memory);
  __attribute__ ((__dllimport__)) size_t __attribute__((__cdecl__)) _get_sbh_threshold(void);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _set_sbh_threshold(size_t _NewValue);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _set_amblksiz(size_t _Value);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _get_amblksiz(size_t *_Value);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _heapadd(void *_Memory,size_t _Size);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _heapchk(void);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _heapmin(void);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _heapset(unsigned int _Fill);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _heapwalk(_HEAPINFO *_EntryInfo);
  __attribute__ ((__dllimport__)) size_t __attribute__((__cdecl__)) _heapused(size_t *_Used,size_t *_Commit);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _get_heap_handle(void);
  static __inline void *_MarkAllocaS(void *_Ptr,unsigned int _Marker) {
    if(_Ptr) {
      *((unsigned int*)_Ptr) = _Marker;
      _Ptr = (char*)_Ptr + 16;
    }
    return _Ptr;
  }
  static __inline void __attribute__((__cdecl__)) _freea(void *_Memory) {
    unsigned int _Marker;
    if(_Memory) {
      _Memory = (char*)_Memory - 16;
      _Marker = *(unsigned int *)_Memory;
      if(_Marker==0xDDDD) {
 free(_Memory);
      }
    }
  }
}
#pragma pack(pop)
       
extern "C++"
{
namespace std
{

  using ::abs;
  inline long
  abs(long __i) { return __builtin_labs(__i); }
  inline long long
  abs(long long __x) { return __builtin_llabs (__x); }
  inline constexpr double
  abs(double __x)
  { return __builtin_fabs(__x); }
  inline constexpr float
  abs(float __x)
  { return __builtin_fabsf(__x); }
  inline constexpr long double
  abs(long double __x)
  { return __builtin_fabsl(__x); }
  inline constexpr __int128
  abs(__int128 __x) { return __x >= 0 ? __x : -__x; }
  inline constexpr
  __float128
  abs(__float128 __x)
  { return __x < 0 ? -__x : __x; }

}
}
extern "C++"
{
namespace std
{

  using ::div_t;
  using ::ldiv_t;
  using ::abort;
  using ::atexit;
  using ::atof;
  using ::atoi;
  using ::atol;
  using ::bsearch;
  using ::calloc;
  using ::div;
  using ::exit;
  using ::free;
  using ::getenv;
  using ::labs;
  using ::ldiv;
  using ::malloc;
  using ::mblen;
  using ::mbstowcs;
  using ::mbtowc;
  using ::qsort;
  using ::rand;
  using ::realloc;
  using ::srand;
  using ::strtod;
  using ::strtol;
  using ::strtoul;
  using ::system;
  using ::wcstombs;
  using ::wctomb;
  inline ldiv_t
  div(long __i, long __j) { return ldiv(__i, __j); }

}
namespace __gnu_cxx
{

  using ::lldiv_t;
  using ::_Exit;
  using ::llabs;
  inline lldiv_t
  div(long long __n, long long __d)
  { lldiv_t __q; __q.quot = __n / __d; __q.rem = __n % __d; return __q; }
  using ::lldiv;
  using ::atoll;
  using ::strtoll;
  using ::strtoull;
  using ::strtof;
  using ::strtold;

}
namespace std
{
  using ::__gnu_cxx::lldiv_t;
  using ::__gnu_cxx::_Exit;
  using ::__gnu_cxx::llabs;
  using ::__gnu_cxx::div;
  using ::__gnu_cxx::lldiv;
  using ::__gnu_cxx::atoll;
  using ::__gnu_cxx::strtof;
  using ::__gnu_cxx::strtoll;
  using ::__gnu_cxx::strtoull;
  using ::__gnu_cxx::strtold;
}
}
       
       
namespace std
{
  using ::FILE;
  using ::fpos_t;
  using ::clearerr;
  using ::fclose;
  using ::feof;
  using ::ferror;
  using ::fflush;
  using ::fgetc;
  using ::fgetpos;
  using ::fgets;
  using ::fopen;
  using ::fprintf;
  using ::fputc;
  using ::fputs;
  using ::fread;
  using ::freopen;
  using ::fscanf;
  using ::fseek;
  using ::fsetpos;
  using ::ftell;
  using ::fwrite;
  using ::getc;
  using ::getchar;
  using ::perror;
  using ::printf;
  using ::putc;
  using ::putchar;
  using ::puts;
  using ::remove;
  using ::rename;
  using ::rewind;
  using ::scanf;
  using ::setbuf;
  using ::setvbuf;
  using ::sprintf;
  using ::sscanf;
  using ::tmpfile;
  using ::tmpnam;
  using ::ungetc;
  using ::vfprintf;
  using ::vprintf;
  using ::vsprintf;
}
namespace __gnu_cxx
{
  using ::snprintf;
  using ::vfscanf;
  using ::vscanf;
  using ::vsnprintf;
  using ::vsscanf;
}
namespace std
{
  using ::__gnu_cxx::snprintf;
  using ::__gnu_cxx::vfscanf;
  using ::__gnu_cxx::vscanf;
  using ::__gnu_cxx::vsnprintf;
  using ::__gnu_cxx::vsscanf;
}
       
namespace __gnu_cxx
{

  template<typename _TRet, typename _Ret = _TRet, typename _CharT,
    typename... _Base>
    _Ret
    __stoa(_TRet (*__convf) (const _CharT*, _CharT**, _Base...),
    const char* __name, const _CharT* __str, std::size_t* __idx,
    _Base... __base)
    {
      _Ret __ret;
      _CharT* __endptr;
      struct _Save_errno {
 _Save_errno() : _M_errno((*_errno())) { (*_errno()) = 0; }
 ~_Save_errno() { if ((*_errno()) == 0) (*_errno()) = _M_errno; }
 int _M_errno;
      } const __save_errno;
      struct _Range_chk {
   static bool
   _S_chk(_TRet, std::false_type) { return false; }
   static bool
   _S_chk(_TRet __val, std::true_type)
   {
     return __val < _TRet(__numeric_traits<int>::__min)
       || __val > _TRet(__numeric_traits<int>::__max);
   }
      };
      const _TRet __tmp = __convf(__str, &__endptr, __base...);
      if (__endptr == __str)
 std::__throw_invalid_argument(__name);
      else if ((*_errno()) == 34
   || _Range_chk::_S_chk(__tmp, std::is_same<_Ret, int>{}))
 std::__throw_out_of_range(__name);
      else
 __ret = __tmp;
      if (__idx)
 *__idx = __endptr - __str;
      return __ret;
    }
  template<typename _String, typename _CharT = typename _String::value_type>
    _String
    __to_xstring(int (*__convf) (_CharT*, std::size_t, const _CharT*,
     __builtin_va_list), std::size_t __n,
   const _CharT* __fmt, ...)
    {
      _CharT* __s = static_cast<_CharT*>(__builtin_alloca(sizeof(_CharT)
         * __n));
      __builtin_va_list __args;
      __builtin_va_start(__args, __fmt);
      const int __len = __convf(__s, __n, __fmt, __args);
      __builtin_va_end(__args);
      return _String(__s, __s + __len);
    }

}
namespace std
{

namespace __cxx11 {
  inline int
  stoi(const string& __str, size_t* __idx = 0, int __base = 10)
  { return __gnu_cxx::__stoa<long, int>(&std::strtol, "stoi", __str.c_str(),
     __idx, __base); }
  inline long
  stol(const string& __str, size_t* __idx = 0, int __base = 10)
  { return __gnu_cxx::__stoa(&std::strtol, "stol", __str.c_str(),
        __idx, __base); }
  inline unsigned long
  stoul(const string& __str, size_t* __idx = 0, int __base = 10)
  { return __gnu_cxx::__stoa(&std::strtoul, "stoul", __str.c_str(),
        __idx, __base); }
  inline long long
  stoll(const string& __str, size_t* __idx = 0, int __base = 10)
  { return __gnu_cxx::__stoa(&std::strtoll, "stoll", __str.c_str(),
        __idx, __base); }
  inline unsigned long long
  stoull(const string& __str, size_t* __idx = 0, int __base = 10)
  { return __gnu_cxx::__stoa(&std::strtoull, "stoull", __str.c_str(),
        __idx, __base); }
  inline float
  stof(const string& __str, size_t* __idx = 0)
  { return __gnu_cxx::__stoa(&std::strtof, "stof", __str.c_str(), __idx); }
  inline double
  stod(const string& __str, size_t* __idx = 0)
  { return __gnu_cxx::__stoa(&std::strtod, "stod", __str.c_str(), __idx); }
  inline long double
  stold(const string& __str, size_t* __idx = 0)
  { return __gnu_cxx::__stoa(&std::strtold, "stold", __str.c_str(), __idx); }
  inline string
  to_string(int __val)
  { return __gnu_cxx::__to_xstring<string>(&std::vsnprintf, 4 * sizeof(int),
        "%d", __val); }
  inline string
  to_string(unsigned __val)
  { return __gnu_cxx::__to_xstring<string>(&std::vsnprintf,
        4 * sizeof(unsigned),
        "%u", __val); }
  inline string
  to_string(long __val)
  { return __gnu_cxx::__to_xstring<string>(&std::vsnprintf, 4 * sizeof(long),
        "%ld", __val); }
  inline string
  to_string(unsigned long __val)
  { return __gnu_cxx::__to_xstring<string>(&std::vsnprintf,
        4 * sizeof(unsigned long),
        "%lu", __val); }
  inline string
  to_string(long long __val)
  { return __gnu_cxx::__to_xstring<string>(&std::vsnprintf,
        4 * sizeof(long long),
        "%lld", __val); }
  inline string
  to_string(unsigned long long __val)
  { return __gnu_cxx::__to_xstring<string>(&std::vsnprintf,
        4 * sizeof(unsigned long long),
        "%llu", __val); }
  inline string
  to_string(float __val)
  {
    const int __n =
      __gnu_cxx::__numeric_traits<float>::__max_exponent10 + 20;
    return __gnu_cxx::__to_xstring<string>(&std::vsnprintf, __n,
        "%f", __val);
  }
  inline string
  to_string(double __val)
  {
    const int __n =
      __gnu_cxx::__numeric_traits<double>::__max_exponent10 + 20;
    return __gnu_cxx::__to_xstring<string>(&std::vsnprintf, __n,
        "%f", __val);
  }
  inline string
  to_string(long double __val)
  {
    const int __n =
      __gnu_cxx::__numeric_traits<long double>::__max_exponent10 + 20;
    return __gnu_cxx::__to_xstring<string>(&std::vsnprintf, __n,
        "%Lf", __val);
  }
  inline int
  stoi(const wstring& __str, size_t* __idx = 0, int __base = 10)
  { return __gnu_cxx::__stoa<long, int>(&std::wcstol, "stoi", __str.c_str(),
     __idx, __base); }
  inline long
  stol(const wstring& __str, size_t* __idx = 0, int __base = 10)
  { return __gnu_cxx::__stoa(&std::wcstol, "stol", __str.c_str(),
        __idx, __base); }
  inline unsigned long
  stoul(const wstring& __str, size_t* __idx = 0, int __base = 10)
  { return __gnu_cxx::__stoa(&std::wcstoul, "stoul", __str.c_str(),
        __idx, __base); }
  inline long long
  stoll(const wstring& __str, size_t* __idx = 0, int __base = 10)
  { return __gnu_cxx::__stoa(&std::wcstoll, "stoll", __str.c_str(),
        __idx, __base); }
  inline unsigned long long
  stoull(const wstring& __str, size_t* __idx = 0, int __base = 10)
  { return __gnu_cxx::__stoa(&std::wcstoull, "stoull", __str.c_str(),
        __idx, __base); }
  inline float
  stof(const wstring& __str, size_t* __idx = 0)
  { return __gnu_cxx::__stoa(&std::wcstof, "stof", __str.c_str(), __idx); }
  inline double
  stod(const wstring& __str, size_t* __idx = 0)
  { return __gnu_cxx::__stoa(&std::wcstod, "stod", __str.c_str(), __idx); }
  inline long double
  stold(const wstring& __str, size_t* __idx = 0)
  { return __gnu_cxx::__stoa(&std::wcstold, "stold", __str.c_str(), __idx); }
  inline wstring
  to_wstring(int __val)
  { return __gnu_cxx::__to_xstring<wstring>(&std::vswprintf, 4 * sizeof(int),
         L"%d", __val); }
  inline wstring
  to_wstring(unsigned __val)
  { return __gnu_cxx::__to_xstring<wstring>(&std::vswprintf,
         4 * sizeof(unsigned),
         L"%u", __val); }
  inline wstring
  to_wstring(long __val)
  { return __gnu_cxx::__to_xstring<wstring>(&std::vswprintf, 4 * sizeof(long),
         L"%ld", __val); }
  inline wstring
  to_wstring(unsigned long __val)
  { return __gnu_cxx::__to_xstring<wstring>(&std::vswprintf,
         4 * sizeof(unsigned long),
         L"%lu", __val); }
  inline wstring
  to_wstring(long long __val)
  { return __gnu_cxx::__to_xstring<wstring>(&std::vswprintf,
         4 * sizeof(long long),
         L"%lld", __val); }
  inline wstring
  to_wstring(unsigned long long __val)
  { return __gnu_cxx::__to_xstring<wstring>(&std::vswprintf,
         4 * sizeof(unsigned long long),
         L"%llu", __val); }
  inline wstring
  to_wstring(float __val)
  {
    const int __n =
      __gnu_cxx::__numeric_traits<float>::__max_exponent10 + 20;
    return __gnu_cxx::__to_xstring<wstring>(&std::vswprintf, __n,
         L"%f", __val);
  }
  inline wstring
  to_wstring(double __val)
  {
    const int __n =
      __gnu_cxx::__numeric_traits<double>::__max_exponent10 + 20;
    return __gnu_cxx::__to_xstring<wstring>(&std::vswprintf, __n,
         L"%f", __val);
  }
  inline wstring
  to_wstring(long double __val)
  {
    const int __n =
      __gnu_cxx::__numeric_traits<long double>::__max_exponent10 + 20;
    return __gnu_cxx::__to_xstring<wstring>(&std::vswprintf, __n,
         L"%Lf", __val);
  }
}

}
       
namespace std
{

  template<typename _Result, typename _Arg>
    struct __hash_base
    {
      typedef _Result result_type ;
      typedef _Arg argument_type ;
    };
  template<typename _Tp>
    struct hash;
  template<typename _Tp, typename = void>
    struct __poison_hash
    {
      static constexpr bool __enable_hash_call = false;
    private:
      __poison_hash(__poison_hash&&);
      ~__poison_hash();
    };
  template<typename _Tp>
    struct __poison_hash<_Tp, __void_t<decltype(hash<_Tp>()(declval<_Tp>()))>>
    {
      static constexpr bool __enable_hash_call = true;
    };
  template<typename _Tp, bool = is_enum<_Tp>::value>
    struct __hash_enum
    {
    private:
      __hash_enum(__hash_enum&&);
      ~__hash_enum();
    };
  template<typename _Tp>
    struct __hash_enum<_Tp, true> : public __hash_base<size_t, _Tp>
    {
      size_t
      operator()(_Tp __val) const noexcept
      {
       using __type = typename underlying_type<_Tp>::type;
       return hash<__type>{}(static_cast<__type>(__val));
      }
    };
  template<typename _Tp>
    struct hash : __hash_enum<_Tp>
    { };
  template<typename _Tp>
    struct hash<_Tp*> : public __hash_base<size_t, _Tp*>
    {
      size_t
      operator()(_Tp* __p) const noexcept
      { return reinterpret_cast<size_t>(__p); }
    };
  template<> struct hash<bool> : public __hash_base<size_t, bool> { size_t operator()(bool __val) const noexcept { return static_cast<size_t>(__val); } };
  template<> struct hash<char> : public __hash_base<size_t, char> { size_t operator()(char __val) const noexcept { return static_cast<size_t>(__val); } };
  template<> struct hash<signed char> : public __hash_base<size_t, signed char> { size_t operator()(signed char __val) const noexcept { return static_cast<size_t>(__val); } };
  template<> struct hash<unsigned char> : public __hash_base<size_t, unsigned char> { size_t operator()(unsigned char __val) const noexcept { return static_cast<size_t>(__val); } };
  template<> struct hash<wchar_t> : public __hash_base<size_t, wchar_t> { size_t operator()(wchar_t __val) const noexcept { return static_cast<size_t>(__val); } };
  template<> struct hash<char16_t> : public __hash_base<size_t, char16_t> { size_t operator()(char16_t __val) const noexcept { return static_cast<size_t>(__val); } };
  template<> struct hash<char32_t> : public __hash_base<size_t, char32_t> { size_t operator()(char32_t __val) const noexcept { return static_cast<size_t>(__val); } };
  template<> struct hash<short> : public __hash_base<size_t, short> { size_t operator()(short __val) const noexcept { return static_cast<size_t>(__val); } };
  template<> struct hash<int> : public __hash_base<size_t, int> { size_t operator()(int __val) const noexcept { return static_cast<size_t>(__val); } };
  template<> struct hash<long> : public __hash_base<size_t, long> { size_t operator()(long __val) const noexcept { return static_cast<size_t>(__val); } };
  template<> struct hash<long long> : public __hash_base<size_t, long long> { size_t operator()(long long __val) const noexcept { return static_cast<size_t>(__val); } };
  template<> struct hash<unsigned short> : public __hash_base<size_t, unsigned short> { size_t operator()(unsigned short __val) const noexcept { return static_cast<size_t>(__val); } };
  template<> struct hash<unsigned int> : public __hash_base<size_t, unsigned int> { size_t operator()(unsigned int __val) const noexcept { return static_cast<size_t>(__val); } };
  template<> struct hash<unsigned long> : public __hash_base<size_t, unsigned long> { size_t operator()(unsigned long __val) const noexcept { return static_cast<size_t>(__val); } };
  template<> struct hash<unsigned long long> : public __hash_base<size_t, unsigned long long> { size_t operator()(unsigned long long __val) const noexcept { return static_cast<size_t>(__val); } };
  template<> struct hash<__int128> : public __hash_base<size_t, __int128> { size_t operator()(__int128 __val) const noexcept { return static_cast<size_t>(__val); } };
  template<> struct hash<__int128 unsigned> : public __hash_base<size_t, __int128 unsigned> { size_t operator()(__int128 unsigned __val) const noexcept { return static_cast<size_t>(__val); } };
  struct _Hash_impl
  {
    static size_t
    hash(const void* __ptr, size_t __clength,
  size_t __seed = static_cast<size_t>(0xc70f6907UL))
    { return _Hash_bytes(__ptr, __clength, __seed); }
    template<typename _Tp>
      static size_t
      hash(const _Tp& __val)
      { return hash(&__val, sizeof(__val)); }
    template<typename _Tp>
      static size_t
      __hash_combine(const _Tp& __val, size_t __hash)
      { return hash(&__val, sizeof(__val), __hash); }
  };
  struct _Fnv_hash_impl
  {
    static size_t
    hash(const void* __ptr, size_t __clength,
  size_t __seed = static_cast<size_t>(2166136261UL))
    { return _Fnv_hash_bytes(__ptr, __clength, __seed); }
    template<typename _Tp>
      static size_t
      hash(const _Tp& __val)
      { return hash(&__val, sizeof(__val)); }
    template<typename _Tp>
      static size_t
      __hash_combine(const _Tp& __val, size_t __hash)
      { return hash(&__val, sizeof(__val), __hash); }
  };
  template<>
    struct hash<float> : public __hash_base<size_t, float>
    {
      size_t
      operator()(float __val) const noexcept
      {
 return __val != 0.0f ? std::_Hash_impl::hash(__val) : 0;
      }
    };
  template<>
    struct hash<double> : public __hash_base<size_t, double>
    {
      size_t
      operator()(double __val) const noexcept
      {
 return __val != 0.0 ? std::_Hash_impl::hash(__val) : 0;
      }
    };
  template<>
    struct hash<long double>
    : public __hash_base<size_t, long double>
    {
      __attribute__ ((__pure__)) size_t
      operator()(long double __val) const noexcept;
    };
  template<typename _Hash>
    struct __is_fast_hash : public std::true_type
    { };
  template<>
    struct __is_fast_hash<hash<long double>> : public std::false_type
    { };

}
namespace std
{

  template<>
    struct hash<string>
    : public __hash_base<size_t, string>
    {
      size_t
      operator()(const string& __s) const noexcept
      { return std::_Hash_impl::hash(__s.data(), __s.length()); }
    };
  template<>
    struct __is_fast_hash<hash<string>> : std::false_type
    { };
  template<>
    struct hash<wstring>
    : public __hash_base<size_t, wstring>
    {
      size_t
      operator()(const wstring& __s) const noexcept
      { return std::_Hash_impl::hash(__s.data(),
                                     __s.length() * sizeof(wchar_t)); }
    };
  template<>
    struct __is_fast_hash<hash<wstring>> : std::false_type
    { };
  template<>
    struct hash<u16string>
    : public __hash_base<size_t, u16string>
    {
      size_t
      operator()(const u16string& __s) const noexcept
      { return std::_Hash_impl::hash(__s.data(),
                                     __s.length() * sizeof(char16_t)); }
    };
  template<>
    struct __is_fast_hash<hash<u16string>> : std::false_type
    { };
  template<>
    struct hash<u32string>
    : public __hash_base<size_t, u32string>
    {
      size_t
      operator()(const u32string& __s) const noexcept
      { return std::_Hash_impl::hash(__s.data(),
                                     __s.length() * sizeof(char32_t)); }
    };
  template<>
    struct __is_fast_hash<hash<u32string>> : std::false_type
    { };
  inline namespace literals
  {
  inline namespace string_literals
  {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wliteral-suffix"
    __attribute ((__abi_tag__ ("cxx11")))
    inline basic_string<char>
    operator""s(const char* __str, size_t __len)
    { return basic_string<char>{__str, __len}; }
    __attribute ((__abi_tag__ ("cxx11")))
    inline basic_string<wchar_t>
    operator""s(const wchar_t* __str, size_t __len)
    { return basic_string<wchar_t>{__str, __len}; }
    __attribute ((__abi_tag__ ("cxx11")))
    inline basic_string<char16_t>
    operator""s(const char16_t* __str, size_t __len)
    { return basic_string<char16_t>{__str, __len}; }
    __attribute ((__abi_tag__ ("cxx11")))
    inline basic_string<char32_t>
    operator""s(const char32_t* __str, size_t __len)
    { return basic_string<char32_t>{__str, __len}; }
#pragma GCC diagnostic pop
  }
  }

}
       
namespace std
{

  template<typename _CharT, typename _Traits, typename _Alloc>
    const typename basic_string<_CharT, _Traits, _Alloc>::size_type
    basic_string<_CharT, _Traits, _Alloc>::npos;
  template<typename _CharT, typename _Traits, typename _Alloc>
    void
    basic_string<_CharT, _Traits, _Alloc>::
    swap(basic_string& __s) noexcept
    {
      if (this == &__s)
 return;
      _Alloc_traits::_S_on_swap(_M_get_allocator(), __s._M_get_allocator());
      if (_M_is_local())
 if (__s._M_is_local())
   {
     if (length() && __s.length())
       {
  _CharT __tmp_data[_S_local_capacity + 1];
  traits_type::copy(__tmp_data, __s._M_local_buf,
      _S_local_capacity + 1);
  traits_type::copy(__s._M_local_buf, _M_local_buf,
      _S_local_capacity + 1);
  traits_type::copy(_M_local_buf, __tmp_data,
      _S_local_capacity + 1);
       }
     else if (__s.length())
       {
  traits_type::copy(_M_local_buf, __s._M_local_buf,
      _S_local_capacity + 1);
  _M_length(__s.length());
  __s._M_set_length(0);
  return;
       }
     else if (length())
       {
  traits_type::copy(__s._M_local_buf, _M_local_buf,
      _S_local_capacity + 1);
  __s._M_length(length());
  _M_set_length(0);
  return;
       }
   }
 else
   {
     const size_type __tmp_capacity = __s._M_allocated_capacity;
     traits_type::copy(__s._M_local_buf, _M_local_buf,
         _S_local_capacity + 1);
     _M_data(__s._M_data());
     __s._M_data(__s._M_local_buf);
     _M_capacity(__tmp_capacity);
   }
      else
 {
   const size_type __tmp_capacity = _M_allocated_capacity;
   if (__s._M_is_local())
     {
       traits_type::copy(_M_local_buf, __s._M_local_buf,
    _S_local_capacity + 1);
       __s._M_data(_M_data());
       _M_data(_M_local_buf);
     }
   else
     {
       pointer __tmp_ptr = _M_data();
       _M_data(__s._M_data());
       __s._M_data(__tmp_ptr);
       _M_capacity(__s._M_allocated_capacity);
     }
   __s._M_capacity(__tmp_capacity);
 }
      const size_type __tmp_length = length();
      _M_length(__s.length());
      __s._M_length(__tmp_length);
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    typename basic_string<_CharT, _Traits, _Alloc>::pointer
    basic_string<_CharT, _Traits, _Alloc>::
    _M_create(size_type& __capacity, size_type __old_capacity)
    {
      if (__capacity > max_size())
 std::__throw_length_error(("basic_string::_M_create"));
      if (__capacity > __old_capacity && __capacity < 2 * __old_capacity)
 {
   __capacity = 2 * __old_capacity;
   if (__capacity > max_size())
     __capacity = max_size();
 }
      return _Alloc_traits::allocate(_M_get_allocator(), __capacity + 1);
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    template<typename _InIterator>
      void
      basic_string<_CharT, _Traits, _Alloc>::
      _M_construct(_InIterator __beg, _InIterator __end,
     std::input_iterator_tag)
      {
 size_type __len = 0;
 size_type __capacity = size_type(_S_local_capacity);
 while (__beg != __end && __len < __capacity)
   {
     _M_data()[__len++] = *__beg;
     ++__beg;
   }
 try
   {
     while (__beg != __end)
       {
  if (__len == __capacity)
    {
      __capacity = __len + 1;
      pointer __another = _M_create(__capacity, __len);
      this->_S_copy(__another, _M_data(), __len);
      _M_dispose();
      _M_data(__another);
      _M_capacity(__capacity);
    }
  _M_data()[__len++] = *__beg;
  ++__beg;
       }
   }
 catch(...)
   {
     _M_dispose();
     throw;
   }
 _M_set_length(__len);
      }
  template<typename _CharT, typename _Traits, typename _Alloc>
    template<typename _InIterator>
      void
      basic_string<_CharT, _Traits, _Alloc>::
      _M_construct(_InIterator __beg, _InIterator __end,
     std::forward_iterator_tag)
      {
 if (__gnu_cxx::__is_null_pointer(__beg) && __beg != __end)
   std::__throw_logic_error(("basic_string::" "_M_construct null not valid"));
 size_type __dnew = static_cast<size_type>(std::distance(__beg, __end));
 if (__dnew > size_type(_S_local_capacity))
   {
     _M_data(_M_create(__dnew, size_type(0)));
     _M_capacity(__dnew);
   }
 try
   { this->_S_copy_chars(_M_data(), __beg, __end); }
 catch(...)
   {
     _M_dispose();
     throw;
   }
 _M_set_length(__dnew);
      }
  template<typename _CharT, typename _Traits, typename _Alloc>
    void
    basic_string<_CharT, _Traits, _Alloc>::
    _M_construct(size_type __n, _CharT __c)
    {
      if (__n > size_type(_S_local_capacity))
 {
   _M_data(_M_create(__n, size_type(0)));
   _M_capacity(__n);
 }
      if (__n)
 this->_S_assign(_M_data(), __n, __c);
      _M_set_length(__n);
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    void
    basic_string<_CharT, _Traits, _Alloc>::
    _M_assign(const basic_string& __str)
    {
      if (this != &__str)
 {
   const size_type __rsize = __str.length();
   const size_type __capacity = capacity();
   if (__rsize > __capacity)
     {
       size_type __new_capacity = __rsize;
       pointer __tmp = _M_create(__new_capacity, __capacity);
       _M_dispose();
       _M_data(__tmp);
       _M_capacity(__new_capacity);
     }
   if (__rsize)
     this->_S_copy(_M_data(), __str._M_data(), __rsize);
   _M_set_length(__rsize);
 }
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    void
    basic_string<_CharT, _Traits, _Alloc>::
    reserve(size_type __res)
    {
      if (__res < length())
 __res = length();
      const size_type __capacity = capacity();
      if (__res != __capacity)
 {
   if (__res > __capacity
       || __res > size_type(_S_local_capacity))
     {
       pointer __tmp = _M_create(__res, __capacity);
       this->_S_copy(__tmp, _M_data(), length() + 1);
       _M_dispose();
       _M_data(__tmp);
       _M_capacity(__res);
     }
   else if (!_M_is_local())
     {
       this->_S_copy(_M_local_data(), _M_data(), length() + 1);
       _M_destroy(__capacity);
       _M_data(_M_local_data());
     }
 }
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    void
    basic_string<_CharT, _Traits, _Alloc>::
    _M_mutate(size_type __pos, size_type __len1, const _CharT* __s,
       size_type __len2)
    {
      const size_type __how_much = length() - __pos - __len1;
      size_type __new_capacity = length() + __len2 - __len1;
      pointer __r = _M_create(__new_capacity, capacity());
      if (__pos)
 this->_S_copy(__r, _M_data(), __pos);
      if (__s && __len2)
 this->_S_copy(__r + __pos, __s, __len2);
      if (__how_much)
 this->_S_copy(__r + __pos + __len2,
        _M_data() + __pos + __len1, __how_much);
      _M_dispose();
      _M_data(__r);
      _M_capacity(__new_capacity);
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    void
    basic_string<_CharT, _Traits, _Alloc>::
    _M_erase(size_type __pos, size_type __n)
    {
      const size_type __how_much = length() - __pos - __n;
      if (__how_much && __n)
 this->_S_move(_M_data() + __pos, _M_data() + __pos + __n, __how_much);
      _M_set_length(length() - __n);
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    void
    basic_string<_CharT, _Traits, _Alloc>::
    resize(size_type __n, _CharT __c)
    {
      const size_type __size = this->size();
      if (__size < __n)
 this->append(__n - __size, __c);
      else if (__n < __size)
 this->_M_set_length(__n);
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    basic_string<_CharT, _Traits, _Alloc>&
    basic_string<_CharT, _Traits, _Alloc>::
    _M_append(const _CharT* __s, size_type __n)
    {
      const size_type __len = __n + this->size();
      if (__len <= this->capacity())
 {
   if (__n)
     this->_S_copy(this->_M_data() + this->size(), __s, __n);
 }
      else
 this->_M_mutate(this->size(), size_type(0), __s, __n);
      this->_M_set_length(__len);
      return *this;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    template<typename _InputIterator>
      basic_string<_CharT, _Traits, _Alloc>&
      basic_string<_CharT, _Traits, _Alloc>::
      _M_replace_dispatch(const_iterator __i1, const_iterator __i2,
     _InputIterator __k1, _InputIterator __k2,
     std::__false_type)
      {
 const basic_string __s(__k1, __k2);
 const size_type __n1 = __i2 - __i1;
 return _M_replace(__i1 - begin(), __n1, __s._M_data(),
     __s.size());
      }
  template<typename _CharT, typename _Traits, typename _Alloc>
    basic_string<_CharT, _Traits, _Alloc>&
    basic_string<_CharT, _Traits, _Alloc>::
    _M_replace_aux(size_type __pos1, size_type __n1, size_type __n2,
     _CharT __c)
    {
      _M_check_length(__n1, __n2, "basic_string::_M_replace_aux");
      const size_type __old_size = this->size();
      const size_type __new_size = __old_size + __n2 - __n1;
      if (__new_size <= this->capacity())
 {
   pointer __p = this->_M_data() + __pos1;
   const size_type __how_much = __old_size - __pos1 - __n1;
   if (__how_much && __n1 != __n2)
     this->_S_move(__p + __n2, __p + __n1, __how_much);
 }
      else
 this->_M_mutate(__pos1, __n1, 0, __n2);
      if (__n2)
 this->_S_assign(this->_M_data() + __pos1, __n2, __c);
      this->_M_set_length(__new_size);
      return *this;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    basic_string<_CharT, _Traits, _Alloc>&
    basic_string<_CharT, _Traits, _Alloc>::
    _M_replace(size_type __pos, size_type __len1, const _CharT* __s,
        const size_type __len2)
    {
      _M_check_length(__len1, __len2, "basic_string::_M_replace");
      const size_type __old_size = this->size();
      const size_type __new_size = __old_size + __len2 - __len1;
      if (__new_size <= this->capacity())
 {
   pointer __p = this->_M_data() + __pos;
   const size_type __how_much = __old_size - __pos - __len1;
   if (_M_disjunct(__s))
     {
       if (__how_much && __len1 != __len2)
  this->_S_move(__p + __len2, __p + __len1, __how_much);
       if (__len2)
  this->_S_copy(__p, __s, __len2);
     }
   else
     {
       if (__len2 && __len2 <= __len1)
  this->_S_move(__p, __s, __len2);
       if (__how_much && __len1 != __len2)
  this->_S_move(__p + __len2, __p + __len1, __how_much);
       if (__len2 > __len1)
  {
    if (__s + __len2 <= __p + __len1)
      this->_S_move(__p, __s, __len2);
    else if (__s >= __p + __len1)
      this->_S_copy(__p, __s + __len2 - __len1, __len2);
    else
      {
        const size_type __nleft = (__p + __len1) - __s;
        this->_S_move(__p, __s, __nleft);
        this->_S_copy(__p + __nleft, __p + __len2,
        __len2 - __nleft);
      }
  }
     }
 }
      else
 this->_M_mutate(__pos, __len1, __s, __len2);
      this->_M_set_length(__new_size);
      return *this;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    typename basic_string<_CharT, _Traits, _Alloc>::size_type
    basic_string<_CharT, _Traits, _Alloc>::
    copy(_CharT* __s, size_type __n, size_type __pos) const
    {
      _M_check(__pos, "basic_string::copy");
      __n = _M_limit(__pos, __n);
      ;
      if (__n)
 _S_copy(__s, _M_data() + __pos, __n);
      return __n;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    basic_string<_CharT, _Traits, _Alloc>
    operator+(const _CharT* __lhs,
       const basic_string<_CharT, _Traits, _Alloc>& __rhs)
    {
      ;
      typedef basic_string<_CharT, _Traits, _Alloc> __string_type;
      typedef typename __string_type::size_type __size_type;
      const __size_type __len = _Traits::length(__lhs);
      __string_type __str;
      __str.reserve(__len + __rhs.size());
      __str.append(__lhs, __len);
      __str.append(__rhs);
      return __str;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    basic_string<_CharT, _Traits, _Alloc>
    operator+(_CharT __lhs, const basic_string<_CharT, _Traits, _Alloc>& __rhs)
    {
      typedef basic_string<_CharT, _Traits, _Alloc> __string_type;
      typedef typename __string_type::size_type __size_type;
      __string_type __str;
      const __size_type __len = __rhs.size();
      __str.reserve(__len + 1);
      __str.append(__size_type(1), __lhs);
      __str.append(__rhs);
      return __str;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    typename basic_string<_CharT, _Traits, _Alloc>::size_type
    basic_string<_CharT, _Traits, _Alloc>::
    find(const _CharT* __s, size_type __pos, size_type __n) const
    noexcept
    {
      ;
      const size_type __size = this->size();
      if (__n == 0)
 return __pos <= __size ? __pos : npos;
      if (__pos >= __size)
 return npos;
      const _CharT __elem0 = __s[0];
      const _CharT* const __data = data();
      const _CharT* __first = __data + __pos;
      const _CharT* const __last = __data + __size;
      size_type __len = __size - __pos;
      while (__len >= __n)
 {
   __first = traits_type::find(__first, __len - __n + 1, __elem0);
   if (!__first)
     return npos;
   if (traits_type::compare(__first, __s, __n) == 0)
     return __first - __data;
   __len = __last - ++__first;
 }
      return npos;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    typename basic_string<_CharT, _Traits, _Alloc>::size_type
    basic_string<_CharT, _Traits, _Alloc>::
    find(_CharT __c, size_type __pos) const noexcept
    {
      size_type __ret = npos;
      const size_type __size = this->size();
      if (__pos < __size)
 {
   const _CharT* __data = _M_data();
   const size_type __n = __size - __pos;
   const _CharT* __p = traits_type::find(__data + __pos, __n, __c);
   if (__p)
     __ret = __p - __data;
 }
      return __ret;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    typename basic_string<_CharT, _Traits, _Alloc>::size_type
    basic_string<_CharT, _Traits, _Alloc>::
    rfind(const _CharT* __s, size_type __pos, size_type __n) const
    noexcept
    {
      ;
      const size_type __size = this->size();
      if (__n <= __size)
 {
   __pos = std::min(size_type(__size - __n), __pos);
   const _CharT* __data = _M_data();
   do
     {
       if (traits_type::compare(__data + __pos, __s, __n) == 0)
  return __pos;
     }
   while (__pos-- > 0);
 }
      return npos;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    typename basic_string<_CharT, _Traits, _Alloc>::size_type
    basic_string<_CharT, _Traits, _Alloc>::
    rfind(_CharT __c, size_type __pos) const noexcept
    {
      size_type __size = this->size();
      if (__size)
 {
   if (--__size > __pos)
     __size = __pos;
   for (++__size; __size-- > 0; )
     if (traits_type::eq(_M_data()[__size], __c))
       return __size;
 }
      return npos;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    typename basic_string<_CharT, _Traits, _Alloc>::size_type
    basic_string<_CharT, _Traits, _Alloc>::
    find_first_of(const _CharT* __s, size_type __pos, size_type __n) const
    noexcept
    {
      ;
      for (; __n && __pos < this->size(); ++__pos)
 {
   const _CharT* __p = traits_type::find(__s, __n, _M_data()[__pos]);
   if (__p)
     return __pos;
 }
      return npos;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    typename basic_string<_CharT, _Traits, _Alloc>::size_type
    basic_string<_CharT, _Traits, _Alloc>::
    find_last_of(const _CharT* __s, size_type __pos, size_type __n) const
    noexcept
    {
      ;
      size_type __size = this->size();
      if (__size && __n)
 {
   if (--__size > __pos)
     __size = __pos;
   do
     {
       if (traits_type::find(__s, __n, _M_data()[__size]))
  return __size;
     }
   while (__size-- != 0);
 }
      return npos;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    typename basic_string<_CharT, _Traits, _Alloc>::size_type
    basic_string<_CharT, _Traits, _Alloc>::
    find_first_not_of(const _CharT* __s, size_type __pos, size_type __n) const
    noexcept
    {
      ;
      for (; __pos < this->size(); ++__pos)
 if (!traits_type::find(__s, __n, _M_data()[__pos]))
   return __pos;
      return npos;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    typename basic_string<_CharT, _Traits, _Alloc>::size_type
    basic_string<_CharT, _Traits, _Alloc>::
    find_first_not_of(_CharT __c, size_type __pos) const noexcept
    {
      for (; __pos < this->size(); ++__pos)
 if (!traits_type::eq(_M_data()[__pos], __c))
   return __pos;
      return npos;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    typename basic_string<_CharT, _Traits, _Alloc>::size_type
    basic_string<_CharT, _Traits, _Alloc>::
    find_last_not_of(const _CharT* __s, size_type __pos, size_type __n) const
    noexcept
    {
      ;
      size_type __size = this->size();
      if (__size)
 {
   if (--__size > __pos)
     __size = __pos;
   do
     {
       if (!traits_type::find(__s, __n, _M_data()[__size]))
  return __size;
     }
   while (__size--);
 }
      return npos;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    typename basic_string<_CharT, _Traits, _Alloc>::size_type
    basic_string<_CharT, _Traits, _Alloc>::
    find_last_not_of(_CharT __c, size_type __pos) const noexcept
    {
      size_type __size = this->size();
      if (__size)
 {
   if (--__size > __pos)
     __size = __pos;
   do
     {
       if (!traits_type::eq(_M_data()[__size], __c))
  return __size;
     }
   while (__size--);
 }
      return npos;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    int
    basic_string<_CharT, _Traits, _Alloc>::
    compare(size_type __pos, size_type __n, const basic_string& __str) const
    {
      _M_check(__pos, "basic_string::compare");
      __n = _M_limit(__pos, __n);
      const size_type __osize = __str.size();
      const size_type __len = std::min(__n, __osize);
      int __r = traits_type::compare(_M_data() + __pos, __str.data(), __len);
      if (!__r)
 __r = _S_compare(__n, __osize);
      return __r;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    int
    basic_string<_CharT, _Traits, _Alloc>::
    compare(size_type __pos1, size_type __n1, const basic_string& __str,
     size_type __pos2, size_type __n2) const
    {
      _M_check(__pos1, "basic_string::compare");
      __str._M_check(__pos2, "basic_string::compare");
      __n1 = _M_limit(__pos1, __n1);
      __n2 = __str._M_limit(__pos2, __n2);
      const size_type __len = std::min(__n1, __n2);
      int __r = traits_type::compare(_M_data() + __pos1,
         __str.data() + __pos2, __len);
      if (!__r)
 __r = _S_compare(__n1, __n2);
      return __r;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    int
    basic_string<_CharT, _Traits, _Alloc>::
    compare(const _CharT* __s) const noexcept
    {
      ;
      const size_type __size = this->size();
      const size_type __osize = traits_type::length(__s);
      const size_type __len = std::min(__size, __osize);
      int __r = traits_type::compare(_M_data(), __s, __len);
      if (!__r)
 __r = _S_compare(__size, __osize);
      return __r;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    int
    basic_string <_CharT, _Traits, _Alloc>::
    compare(size_type __pos, size_type __n1, const _CharT* __s) const
    {
      ;
      _M_check(__pos, "basic_string::compare");
      __n1 = _M_limit(__pos, __n1);
      const size_type __osize = traits_type::length(__s);
      const size_type __len = std::min(__n1, __osize);
      int __r = traits_type::compare(_M_data() + __pos, __s, __len);
      if (!__r)
 __r = _S_compare(__n1, __osize);
      return __r;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    int
    basic_string <_CharT, _Traits, _Alloc>::
    compare(size_type __pos, size_type __n1, const _CharT* __s,
     size_type __n2) const
    {
      ;
      _M_check(__pos, "basic_string::compare");
      __n1 = _M_limit(__pos, __n1);
      const size_type __len = std::min(__n1, __n2);
      int __r = traits_type::compare(_M_data() + __pos, __s, __len);
      if (!__r)
 __r = _S_compare(__n1, __n2);
      return __r;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    basic_istream<_CharT, _Traits>&
    operator>>(basic_istream<_CharT, _Traits>& __in,
        basic_string<_CharT, _Traits, _Alloc>& __str)
    {
      typedef basic_istream<_CharT, _Traits> __istream_type;
      typedef basic_string<_CharT, _Traits, _Alloc> __string_type;
      typedef typename __istream_type::ios_base __ios_base;
      typedef typename __istream_type::int_type __int_type;
      typedef typename __string_type::size_type __size_type;
      typedef ctype<_CharT> __ctype_type;
      typedef typename __ctype_type::ctype_base __ctype_base;
      __size_type __extracted = 0;
      typename __ios_base::iostate __err = __ios_base::goodbit;
      typename __istream_type::sentry __cerb(__in, false);
      if (__cerb)
 {
   try
     {
       __str.erase();
       _CharT __buf[128];
       __size_type __len = 0;
       const streamsize __w = __in.width();
       const __size_type __n = __w > 0 ? static_cast<__size_type>(__w)
                                : __str.max_size();
       const __ctype_type& __ct = use_facet<__ctype_type>(__in.getloc());
       const __int_type __eof = _Traits::eof();
       __int_type __c = __in.rdbuf()->sgetc();
       while (__extracted < __n
       && !_Traits::eq_int_type(__c, __eof)
       && !__ct.is(__ctype_base::space,
     _Traits::to_char_type(__c)))
  {
    if (__len == sizeof(__buf) / sizeof(_CharT))
      {
        __str.append(__buf, sizeof(__buf) / sizeof(_CharT));
        __len = 0;
      }
    __buf[__len++] = _Traits::to_char_type(__c);
    ++__extracted;
    __c = __in.rdbuf()->snextc();
  }
       __str.append(__buf, __len);
       if (_Traits::eq_int_type(__c, __eof))
  __err |= __ios_base::eofbit;
       __in.width(0);
     }
   catch(__cxxabiv1::__forced_unwind&)
     {
       __in._M_setstate(__ios_base::badbit);
       throw;
     }
   catch(...)
     {
       __in._M_setstate(__ios_base::badbit);
     }
 }
      if (!__extracted)
 __err |= __ios_base::failbit;
      if (__err)
 __in.setstate(__err);
      return __in;
    }
  template<typename _CharT, typename _Traits, typename _Alloc>
    basic_istream<_CharT, _Traits>&
    getline(basic_istream<_CharT, _Traits>& __in,
     basic_string<_CharT, _Traits, _Alloc>& __str, _CharT __delim)
    {
      typedef basic_istream<_CharT, _Traits> __istream_type;
      typedef basic_string<_CharT, _Traits, _Alloc> __string_type;
      typedef typename __istream_type::ios_base __ios_base;
      typedef typename __istream_type::int_type __int_type;
      typedef typename __string_type::size_type __size_type;
      __size_type __extracted = 0;
      const __size_type __n = __str.max_size();
      typename __ios_base::iostate __err = __ios_base::goodbit;
      typename __istream_type::sentry __cerb(__in, true);
      if (__cerb)
 {
   try
     {
       __str.erase();
       const __int_type __idelim = _Traits::to_int_type(__delim);
       const __int_type __eof = _Traits::eof();
       __int_type __c = __in.rdbuf()->sgetc();
       while (__extracted < __n
       && !_Traits::eq_int_type(__c, __eof)
       && !_Traits::eq_int_type(__c, __idelim))
  {
    __str += _Traits::to_char_type(__c);
    ++__extracted;
    __c = __in.rdbuf()->snextc();
  }
       if (_Traits::eq_int_type(__c, __eof))
  __err |= __ios_base::eofbit;
       else if (_Traits::eq_int_type(__c, __idelim))
  {
    ++__extracted;
    __in.rdbuf()->sbumpc();
  }
       else
  __err |= __ios_base::failbit;
     }
   catch(__cxxabiv1::__forced_unwind&)
     {
       __in._M_setstate(__ios_base::badbit);
       throw;
     }
   catch(...)
     {
       __in._M_setstate(__ios_base::badbit);
     }
 }
      if (!__extracted)
 __err |= __ios_base::failbit;
      if (__err)
 __in.setstate(__err);
      return __in;
    }
  extern template class basic_string<char>;
  extern template
    basic_istream<char>&
    operator>>(basic_istream<char>&, string&);
  extern template
    basic_ostream<char>&
    operator<<(basic_ostream<char>&, const string&);
  extern template
    basic_istream<char>&
    getline(basic_istream<char>&, string&, char);
  extern template
    basic_istream<char>&
    getline(basic_istream<char>&, string&);
  extern template class basic_string<wchar_t>;
  extern template
    basic_istream<wchar_t>&
    operator>>(basic_istream<wchar_t>&, wstring&);
  extern template
    basic_ostream<wchar_t>&
    operator<<(basic_ostream<wchar_t>&, const wstring&);
  extern template
    basic_istream<wchar_t>&
    getline(basic_istream<wchar_t>&, wstring&, wchar_t);
  extern template
    basic_istream<wchar_t>&
    getline(basic_istream<wchar_t>&, wstring&);

}
namespace std
{

  struct __cow_string
  {
    union {
      const char* _M_p;
      char _M_bytes[sizeof(const char*)];
    };
    __cow_string();
    __cow_string(const std::string&);
    __cow_string(const char*, size_t);
    __cow_string(const __cow_string&) noexcept;
    __cow_string& operator=(const __cow_string&) noexcept;
    ~__cow_string();
    __cow_string(__cow_string&&) noexcept;
    __cow_string& operator=(__cow_string&&) noexcept;
  };
  typedef basic_string<char> __sso_string;
  class logic_error : public exception
  {
    __cow_string _M_msg;
  public:
    explicit
    logic_error(const string& __arg) ;
    explicit
    logic_error(const char*) ;
    logic_error(const logic_error&) noexcept;
    logic_error& operator=(const logic_error&) noexcept;
    virtual ~logic_error() noexcept;
    virtual const char*
    what() const noexcept;
  };
  class domain_error : public logic_error
  {
  public:
    explicit domain_error(const string& __arg) ;
    explicit domain_error(const char*) ;
    virtual ~domain_error() noexcept;
  };
  class invalid_argument : public logic_error
  {
  public:
    explicit invalid_argument(const string& __arg) ;
    explicit invalid_argument(const char*) ;
    virtual ~invalid_argument() noexcept;
  };
  class length_error : public logic_error
  {
  public:
    explicit length_error(const string& __arg) ;
    explicit length_error(const char*) ;
    virtual ~length_error() noexcept;
  };
  class out_of_range : public logic_error
  {
  public:
    explicit out_of_range(const string& __arg) ;
    explicit out_of_range(const char*) ;
    virtual ~out_of_range() noexcept;
  };
  class runtime_error : public exception
  {
    __cow_string _M_msg;
  public:
    explicit
    runtime_error(const string& __arg) ;
    explicit
    runtime_error(const char*) ;
    runtime_error(const runtime_error&) noexcept;
    runtime_error& operator=(const runtime_error&) noexcept;
    virtual ~runtime_error() noexcept;
    virtual const char*
    what() const noexcept;
  };
  class range_error : public runtime_error
  {
  public:
    explicit range_error(const string& __arg) ;
    explicit range_error(const char*) ;
    virtual ~range_error() noexcept;
  };
  class overflow_error : public runtime_error
  {
  public:
    explicit overflow_error(const string& __arg) ;
    explicit overflow_error(const char*) ;
    virtual ~overflow_error() noexcept;
  };
  class underflow_error : public runtime_error
  {
  public:
    explicit underflow_error(const string& __arg) ;
    explicit underflow_error(const char*) ;
    virtual ~underflow_error() noexcept;
  };

}
namespace std
{

  template<typename _Tp, std::size_t _Nm>
    struct __array_traits
    {
      typedef _Tp _Type[_Nm];
      typedef __is_swappable<_Tp> _Is_swappable;
      typedef __is_nothrow_swappable<_Tp> _Is_nothrow_swappable;
      static constexpr _Tp&
      _S_ref(const _Type& __t, std::size_t __n) noexcept
      { return const_cast<_Tp&>(__t[__n]); }
      static constexpr _Tp*
      _S_ptr(const _Type& __t) noexcept
      { return const_cast<_Tp*>(__t); }
    };
 template<typename _Tp>
   struct __array_traits<_Tp, 0>
   {
     struct _Type { };
     typedef true_type _Is_swappable;
     typedef true_type _Is_nothrow_swappable;
     static constexpr _Tp&
     _S_ref(const _Type&, std::size_t) noexcept
     { return *static_cast<_Tp*>(nullptr); }
     static constexpr _Tp*
     _S_ptr(const _Type&) noexcept
     { return nullptr; }
   };
  template<typename _Tp, std::size_t _Nm>
    struct array
    {
      typedef _Tp value_type;
      typedef value_type* pointer;
      typedef const value_type* const_pointer;
      typedef value_type& reference;
      typedef const value_type& const_reference;
      typedef value_type* iterator;
      typedef const value_type* const_iterator;
      typedef std::size_t size_type;
      typedef std::ptrdiff_t difference_type;
      typedef std::reverse_iterator<iterator> reverse_iterator;
      typedef std::reverse_iterator<const_iterator> const_reverse_iterator;
      typedef std::__array_traits<_Tp, _Nm> _AT_Type;
      typename _AT_Type::_Type _M_elems;
      void
      fill(const value_type& __u)
      { std::fill_n(begin(), size(), __u); }
      void
      swap(array& __other)
      noexcept(_AT_Type::_Is_nothrow_swappable::value)
      { std::swap_ranges(begin(), end(), __other.begin()); }
      iterator
      begin() noexcept
      { return iterator(data()); }
      const_iterator
      begin() const noexcept
      { return const_iterator(data()); }
      iterator
      end() noexcept
      { return iterator(data() + _Nm); }
      const_iterator
      end() const noexcept
      { return const_iterator(data() + _Nm); }
      reverse_iterator
      rbegin() noexcept
      { return reverse_iterator(end()); }
      const_reverse_iterator
      rbegin() const noexcept
      { return const_reverse_iterator(end()); }
      reverse_iterator
      rend() noexcept
      { return reverse_iterator(begin()); }
      const_reverse_iterator
      rend() const noexcept
      { return const_reverse_iterator(begin()); }
      const_iterator
      cbegin() const noexcept
      { return const_iterator(data()); }
      const_iterator
      cend() const noexcept
      { return const_iterator(data() + _Nm); }
      const_reverse_iterator
      crbegin() const noexcept
      { return const_reverse_iterator(end()); }
      const_reverse_iterator
      crend() const noexcept
      { return const_reverse_iterator(begin()); }
      constexpr size_type
      size() const noexcept { return _Nm; }
      constexpr size_type
      max_size() const noexcept { return _Nm; }
      constexpr bool
      empty() const noexcept { return size() == 0; }
      reference
      operator[](size_type __n) noexcept
      { return _AT_Type::_S_ref(_M_elems, __n); }
      constexpr const_reference
      operator[](size_type __n) const noexcept
      { return _AT_Type::_S_ref(_M_elems, __n); }
      reference
      at(size_type __n)
      {
 if (__n >= _Nm)
   std::__throw_out_of_range_fmt(("array::at: __n (which is %zu) " ">= _Nm (which is %zu)"),
     __n, _Nm);
 return _AT_Type::_S_ref(_M_elems, __n);
      }
      constexpr const_reference
      at(size_type __n) const
      {
 return __n < _Nm ? _AT_Type::_S_ref(_M_elems, __n)
   : (std::__throw_out_of_range_fmt(("array::at: __n (which is %zu) " ">= _Nm (which is %zu)"),
        __n, _Nm),
      _AT_Type::_S_ref(_M_elems, 0));
      }
      reference
      front() noexcept
      { return *begin(); }
      constexpr const_reference
      front() const noexcept
      { return _AT_Type::_S_ref(_M_elems, 0); }
      reference
      back() noexcept
      { return _Nm ? *(end() - 1) : *end(); }
      constexpr const_reference
      back() const noexcept
      {
 return _Nm ? _AT_Type::_S_ref(_M_elems, _Nm - 1)
             : _AT_Type::_S_ref(_M_elems, 0);
      }
      pointer
      data() noexcept
      { return _AT_Type::_S_ptr(_M_elems); }
      const_pointer
      data() const noexcept
      { return _AT_Type::_S_ptr(_M_elems); }
    };
  template<typename _Tp, std::size_t _Nm>
    inline bool
    operator==(const array<_Tp, _Nm>& __one, const array<_Tp, _Nm>& __two)
    { return std::equal(__one.begin(), __one.end(), __two.begin()); }
  template<typename _Tp, std::size_t _Nm>
    inline bool
    operator!=(const array<_Tp, _Nm>& __one, const array<_Tp, _Nm>& __two)
    { return !(__one == __two); }
  template<typename _Tp, std::size_t _Nm>
    inline bool
    operator<(const array<_Tp, _Nm>& __a, const array<_Tp, _Nm>& __b)
    {
      return std::lexicographical_compare(__a.begin(), __a.end(),
       __b.begin(), __b.end());
    }
  template<typename _Tp, std::size_t _Nm>
    inline bool
    operator>(const array<_Tp, _Nm>& __one, const array<_Tp, _Nm>& __two)
    { return __two < __one; }
  template<typename _Tp, std::size_t _Nm>
    inline bool
    operator<=(const array<_Tp, _Nm>& __one, const array<_Tp, _Nm>& __two)
    { return !(__one > __two); }
  template<typename _Tp, std::size_t _Nm>
    inline bool
    operator>=(const array<_Tp, _Nm>& __one, const array<_Tp, _Nm>& __two)
    { return !(__one < __two); }
  template<typename _Tp, std::size_t _Nm>
    inline
    typename enable_if<
      std::__array_traits<_Tp, _Nm>::_Is_swappable::value
    >::type
    swap(array<_Tp, _Nm>& __one, array<_Tp, _Nm>& __two)
    noexcept(noexcept(__one.swap(__two)))
    { __one.swap(__two); }
  template<typename _Tp, std::size_t _Nm>
    typename enable_if<
      !std::__array_traits<_Tp, _Nm>::_Is_swappable::value>::type
    swap(array<_Tp, _Nm>&, array<_Tp, _Nm>&) = delete;
  template<std::size_t _Int, typename _Tp, std::size_t _Nm>
    constexpr _Tp&
    get(array<_Tp, _Nm>& __arr) noexcept
    {
      static_assert(_Int < _Nm, "array index is within bounds");
      return std::__array_traits<_Tp, _Nm>::
 _S_ref(__arr._M_elems, _Int);
    }
  template<std::size_t _Int, typename _Tp, std::size_t _Nm>
    constexpr _Tp&&
    get(array<_Tp, _Nm>&& __arr) noexcept
    {
      static_assert(_Int < _Nm, "array index is within bounds");
      return std::move(std::get<_Int>(__arr));
    }
  template<std::size_t _Int, typename _Tp, std::size_t _Nm>
    constexpr const _Tp&
    get(const array<_Tp, _Nm>& __arr) noexcept
    {
      static_assert(_Int < _Nm, "array index is within bounds");
      return std::__array_traits<_Tp, _Nm>::
 _S_ref(__arr._M_elems, _Int);
    }
  template<std::size_t _Int, typename _Tp, std::size_t _Nm>
    constexpr const _Tp&&
    get(const array<_Tp, _Nm>&& __arr) noexcept
    {
      static_assert(_Int < _Nm, "array index is within bounds");
      return std::move(std::get<_Int>(__arr));
    }

}
namespace std
{

  template<typename _Tp>
    struct tuple_size;
  template<typename _Tp, std::size_t _Nm>
    struct tuple_size<std::array<_Tp, _Nm>>
    : public integral_constant<std::size_t, _Nm> { };
  template<std::size_t _Int, typename _Tp>
    struct tuple_element;
  template<std::size_t _Int, typename _Tp, std::size_t _Nm>
    struct tuple_element<_Int, std::array<_Tp, _Nm>>
    {
      static_assert(_Int < _Nm, "index is out of bounds");
      typedef _Tp type;
    };
  template<typename _Tp, std::size_t _Nm>
    struct __is_tuple_like_impl<std::array<_Tp, _Nm>> : true_type
    { };

}
       
namespace std
{

  template<typename _Tp, typename _Up = typename __inv_unwrap<_Tp>::type>
    constexpr _Up&&
    __invfwd(typename remove_reference<_Tp>::type& __t) noexcept
    { return static_cast<_Up&&>(__t); }
  template<typename _Res, typename _Fn, typename... _Args>
    constexpr _Res
    __invoke_impl(__invoke_other, _Fn&& __f, _Args&&... __args)
    { return std::forward<_Fn>(__f)(std::forward<_Args>(__args)...); }
  template<typename _Res, typename _MemFun, typename _Tp, typename... _Args>
    constexpr _Res
    __invoke_impl(__invoke_memfun_ref, _MemFun&& __f, _Tp&& __t,
    _Args&&... __args)
    { return (__invfwd<_Tp>(__t).*__f)(std::forward<_Args>(__args)...); }
  template<typename _Res, typename _MemFun, typename _Tp, typename... _Args>
    constexpr _Res
    __invoke_impl(__invoke_memfun_deref, _MemFun&& __f, _Tp&& __t,
    _Args&&... __args)
    {
      return ((*std::forward<_Tp>(__t)).*__f)(std::forward<_Args>(__args)...);
    }
  template<typename _Res, typename _MemPtr, typename _Tp>
    constexpr _Res
    __invoke_impl(__invoke_memobj_ref, _MemPtr&& __f, _Tp&& __t)
    { return __invfwd<_Tp>(__t).*__f; }
  template<typename _Res, typename _MemPtr, typename _Tp>
    constexpr _Res
    __invoke_impl(__invoke_memobj_deref, _MemPtr&& __f, _Tp&& __t)
    { return (*std::forward<_Tp>(__t)).*__f; }
  template<typename _Callable, typename... _Args>
    constexpr typename __invoke_result<_Callable, _Args...>::type
    __invoke(_Callable&& __fn, _Args&&... __args)
    noexcept(__is_nothrow_invocable<_Callable, _Args...>::value)
    {
      using __result = __invoke_result<_Callable, _Args...>;
      using __type = typename __result::type;
      using __tag = typename __result::__invoke_type;
      return std::__invoke_impl<__type>(__tag{}, std::forward<_Callable>(__fn),
     std::forward<_Args>(__args)...);
    }

}
namespace std
{

  template<typename... _Elements>
    class tuple;
  template<typename _Tp>
    struct __is_empty_non_tuple : is_empty<_Tp> { };
  template<typename _El0, typename... _El>
    struct __is_empty_non_tuple<tuple<_El0, _El...>> : false_type { };
  template<typename _Tp>
    using __empty_not_final
    = typename conditional<__is_final(_Tp), false_type,
      __is_empty_non_tuple<_Tp>>::type;
  template<std::size_t _Idx, typename _Head,
    bool = __empty_not_final<_Head>::value>
    struct _Head_base;
  template<std::size_t _Idx, typename _Head>
    struct _Head_base<_Idx, _Head, true>
    : public _Head
    {
      constexpr _Head_base()
      : _Head() { }
      constexpr _Head_base(const _Head& __h)
      : _Head(__h) { }
      constexpr _Head_base(const _Head_base&) = default;
      constexpr _Head_base(_Head_base&&) = default;
      template<typename _UHead>
        constexpr _Head_base(_UHead&& __h)
 : _Head(std::forward<_UHead>(__h)) { }
      _Head_base(allocator_arg_t, __uses_alloc0)
      : _Head() { }
      template<typename _Alloc>
 _Head_base(allocator_arg_t, __uses_alloc1<_Alloc> __a)
 : _Head(allocator_arg, *__a._M_a) { }
      template<typename _Alloc>
 _Head_base(allocator_arg_t, __uses_alloc2<_Alloc> __a)
 : _Head(*__a._M_a) { }
      template<typename _UHead>
 _Head_base(__uses_alloc0, _UHead&& __uhead)
 : _Head(std::forward<_UHead>(__uhead)) { }
      template<typename _Alloc, typename _UHead>
 _Head_base(__uses_alloc1<_Alloc> __a, _UHead&& __uhead)
 : _Head(allocator_arg, *__a._M_a, std::forward<_UHead>(__uhead)) { }
      template<typename _Alloc, typename _UHead>
 _Head_base(__uses_alloc2<_Alloc> __a, _UHead&& __uhead)
 : _Head(std::forward<_UHead>(__uhead), *__a._M_a) { }
      static constexpr _Head&
      _M_head(_Head_base& __b) noexcept { return __b; }
      static constexpr const _Head&
      _M_head(const _Head_base& __b) noexcept { return __b; }
    };
  template<std::size_t _Idx, typename _Head>
    struct _Head_base<_Idx, _Head, false>
    {
      constexpr _Head_base()
      : _M_head_impl() { }
      constexpr _Head_base(const _Head& __h)
      : _M_head_impl(__h) { }
      constexpr _Head_base(const _Head_base&) = default;
      constexpr _Head_base(_Head_base&&) = default;
      template<typename _UHead>
        constexpr _Head_base(_UHead&& __h)
 : _M_head_impl(std::forward<_UHead>(__h)) { }
      _Head_base(allocator_arg_t, __uses_alloc0)
      : _M_head_impl() { }
      template<typename _Alloc>
 _Head_base(allocator_arg_t, __uses_alloc1<_Alloc> __a)
 : _M_head_impl(allocator_arg, *__a._M_a) { }
      template<typename _Alloc>
 _Head_base(allocator_arg_t, __uses_alloc2<_Alloc> __a)
 : _M_head_impl(*__a._M_a) { }
      template<typename _UHead>
 _Head_base(__uses_alloc0, _UHead&& __uhead)
 : _M_head_impl(std::forward<_UHead>(__uhead)) { }
      template<typename _Alloc, typename _UHead>
 _Head_base(__uses_alloc1<_Alloc> __a, _UHead&& __uhead)
 : _M_head_impl(allocator_arg, *__a._M_a, std::forward<_UHead>(__uhead))
 { }
      template<typename _Alloc, typename _UHead>
 _Head_base(__uses_alloc2<_Alloc> __a, _UHead&& __uhead)
 : _M_head_impl(std::forward<_UHead>(__uhead), *__a._M_a) { }
      static constexpr _Head&
      _M_head(_Head_base& __b) noexcept { return __b._M_head_impl; }
      static constexpr const _Head&
      _M_head(const _Head_base& __b) noexcept { return __b._M_head_impl; }
      _Head _M_head_impl;
    };
  template<std::size_t _Idx, typename... _Elements>
    struct _Tuple_impl;
  template<std::size_t _Idx, typename _Head, typename... _Tail>
    struct _Tuple_impl<_Idx, _Head, _Tail...>
    : public _Tuple_impl<_Idx + 1, _Tail...>,
      private _Head_base<_Idx, _Head>
    {
      template<std::size_t, typename...> friend class _Tuple_impl;
      typedef _Tuple_impl<_Idx + 1, _Tail...> _Inherited;
      typedef _Head_base<_Idx, _Head> _Base;
      static constexpr _Head&
      _M_head(_Tuple_impl& __t) noexcept { return _Base::_M_head(__t); }
      static constexpr const _Head&
      _M_head(const _Tuple_impl& __t) noexcept { return _Base::_M_head(__t); }
      static constexpr _Inherited&
      _M_tail(_Tuple_impl& __t) noexcept { return __t; }
      static constexpr const _Inherited&
      _M_tail(const _Tuple_impl& __t) noexcept { return __t; }
      constexpr _Tuple_impl()
      : _Inherited(), _Base() { }
      explicit
      constexpr _Tuple_impl(const _Head& __head, const _Tail&... __tail)
      : _Inherited(__tail...), _Base(__head) { }
      template<typename _UHead, typename... _UTail, typename = typename
               enable_if<sizeof...(_Tail) == sizeof...(_UTail)>::type>
        explicit
        constexpr _Tuple_impl(_UHead&& __head, _UTail&&... __tail)
 : _Inherited(std::forward<_UTail>(__tail)...),
   _Base(std::forward<_UHead>(__head)) { }
      constexpr _Tuple_impl(const _Tuple_impl&) = default;
      constexpr
      _Tuple_impl(_Tuple_impl&& __in)
      noexcept(__and_<is_nothrow_move_constructible<_Head>,
               is_nothrow_move_constructible<_Inherited>>::value)
      : _Inherited(std::move(_M_tail(__in))),
 _Base(std::forward<_Head>(_M_head(__in))) { }
      template<typename... _UElements>
        constexpr _Tuple_impl(const _Tuple_impl<_Idx, _UElements...>& __in)
 : _Inherited(_Tuple_impl<_Idx, _UElements...>::_M_tail(__in)),
   _Base(_Tuple_impl<_Idx, _UElements...>::_M_head(__in)) { }
      template<typename _UHead, typename... _UTails>
        constexpr _Tuple_impl(_Tuple_impl<_Idx, _UHead, _UTails...>&& __in)
 : _Inherited(std::move
       (_Tuple_impl<_Idx, _UHead, _UTails...>::_M_tail(__in))),
   _Base(std::forward<_UHead>
  (_Tuple_impl<_Idx, _UHead, _UTails...>::_M_head(__in))) { }
      template<typename _Alloc>
 _Tuple_impl(allocator_arg_t __tag, const _Alloc& __a)
 : _Inherited(__tag, __a),
          _Base(__tag, __use_alloc<_Head>(__a)) { }
      template<typename _Alloc>
 _Tuple_impl(allocator_arg_t __tag, const _Alloc& __a,
      const _Head& __head, const _Tail&... __tail)
 : _Inherited(__tag, __a, __tail...),
          _Base(__use_alloc<_Head, _Alloc, _Head>(__a), __head) { }
      template<typename _Alloc, typename _UHead, typename... _UTail,
               typename = typename enable_if<sizeof...(_Tail)
          == sizeof...(_UTail)>::type>
 _Tuple_impl(allocator_arg_t __tag, const _Alloc& __a,
             _UHead&& __head, _UTail&&... __tail)
 : _Inherited(__tag, __a, std::forward<_UTail>(__tail)...),
          _Base(__use_alloc<_Head, _Alloc, _UHead>(__a),
         std::forward<_UHead>(__head)) { }
      template<typename _Alloc>
        _Tuple_impl(allocator_arg_t __tag, const _Alloc& __a,
             const _Tuple_impl& __in)
 : _Inherited(__tag, __a, _M_tail(__in)),
          _Base(__use_alloc<_Head, _Alloc, _Head>(__a), _M_head(__in)) { }
      template<typename _Alloc>
 _Tuple_impl(allocator_arg_t __tag, const _Alloc& __a,
             _Tuple_impl&& __in)
 : _Inherited(__tag, __a, std::move(_M_tail(__in))),
   _Base(__use_alloc<_Head, _Alloc, _Head>(__a),
         std::forward<_Head>(_M_head(__in))) { }
      template<typename _Alloc, typename... _UElements>
 _Tuple_impl(allocator_arg_t __tag, const _Alloc& __a,
             const _Tuple_impl<_Idx, _UElements...>& __in)
 : _Inherited(__tag, __a,
       _Tuple_impl<_Idx, _UElements...>::_M_tail(__in)),
   _Base(__use_alloc<_Head, _Alloc, _Head>(__a),
  _Tuple_impl<_Idx, _UElements...>::_M_head(__in)) { }
      template<typename _Alloc, typename _UHead, typename... _UTails>
 _Tuple_impl(allocator_arg_t __tag, const _Alloc& __a,
             _Tuple_impl<_Idx, _UHead, _UTails...>&& __in)
 : _Inherited(__tag, __a, std::move
       (_Tuple_impl<_Idx, _UHead, _UTails...>::_M_tail(__in))),
   _Base(__use_alloc<_Head, _Alloc, _UHead>(__a),
                std::forward<_UHead>
  (_Tuple_impl<_Idx, _UHead, _UTails...>::_M_head(__in))) { }
      _Tuple_impl&
      operator=(const _Tuple_impl& __in)
      {
 _M_head(*this) = _M_head(__in);
 _M_tail(*this) = _M_tail(__in);
 return *this;
      }
      _Tuple_impl&
      operator=(_Tuple_impl&& __in)
      noexcept(__and_<is_nothrow_move_assignable<_Head>,
               is_nothrow_move_assignable<_Inherited>>::value)
      {
 _M_head(*this) = std::forward<_Head>(_M_head(__in));
 _M_tail(*this) = std::move(_M_tail(__in));
 return *this;
      }
      template<typename... _UElements>
        _Tuple_impl&
        operator=(const _Tuple_impl<_Idx, _UElements...>& __in)
        {
   _M_head(*this) = _Tuple_impl<_Idx, _UElements...>::_M_head(__in);
   _M_tail(*this) = _Tuple_impl<_Idx, _UElements...>::_M_tail(__in);
   return *this;
 }
      template<typename _UHead, typename... _UTails>
        _Tuple_impl&
        operator=(_Tuple_impl<_Idx, _UHead, _UTails...>&& __in)
        {
   _M_head(*this) = std::forward<_UHead>
     (_Tuple_impl<_Idx, _UHead, _UTails...>::_M_head(__in));
   _M_tail(*this) = std::move
     (_Tuple_impl<_Idx, _UHead, _UTails...>::_M_tail(__in));
   return *this;
 }
    protected:
      void
      _M_swap(_Tuple_impl& __in)
      noexcept(__is_nothrow_swappable<_Head>::value
               && noexcept(_M_tail(__in)._M_swap(_M_tail(__in))))
      {
 using std::swap;
 swap(_M_head(*this), _M_head(__in));
 _Inherited::_M_swap(_M_tail(__in));
      }
    };
  template<std::size_t _Idx, typename _Head>
    struct _Tuple_impl<_Idx, _Head>
    : private _Head_base<_Idx, _Head>
    {
      template<std::size_t, typename...> friend class _Tuple_impl;
      typedef _Head_base<_Idx, _Head> _Base;
      static constexpr _Head&
      _M_head(_Tuple_impl& __t) noexcept { return _Base::_M_head(__t); }
      static constexpr const _Head&
      _M_head(const _Tuple_impl& __t) noexcept { return _Base::_M_head(__t); }
      constexpr _Tuple_impl()
      : _Base() { }
      explicit
      constexpr _Tuple_impl(const _Head& __head)
      : _Base(__head) { }
      template<typename _UHead>
        explicit
        constexpr _Tuple_impl(_UHead&& __head)
 : _Base(std::forward<_UHead>(__head)) { }
      constexpr _Tuple_impl(const _Tuple_impl&) = default;
      constexpr
      _Tuple_impl(_Tuple_impl&& __in)
      noexcept(is_nothrow_move_constructible<_Head>::value)
      : _Base(std::forward<_Head>(_M_head(__in))) { }
      template<typename _UHead>
        constexpr _Tuple_impl(const _Tuple_impl<_Idx, _UHead>& __in)
 : _Base(_Tuple_impl<_Idx, _UHead>::_M_head(__in)) { }
      template<typename _UHead>
        constexpr _Tuple_impl(_Tuple_impl<_Idx, _UHead>&& __in)
 : _Base(std::forward<_UHead>(_Tuple_impl<_Idx, _UHead>::_M_head(__in)))
 { }
      template<typename _Alloc>
 _Tuple_impl(allocator_arg_t __tag, const _Alloc& __a)
 : _Base(__tag, __use_alloc<_Head>(__a)) { }
      template<typename _Alloc>
 _Tuple_impl(allocator_arg_t __tag, const _Alloc& __a,
      const _Head& __head)
 : _Base(__use_alloc<_Head, _Alloc, _Head>(__a), __head) { }
      template<typename _Alloc, typename _UHead>
 _Tuple_impl(allocator_arg_t __tag, const _Alloc& __a,
             _UHead&& __head)
 : _Base(__use_alloc<_Head, _Alloc, _UHead>(__a),
         std::forward<_UHead>(__head)) { }
      template<typename _Alloc>
        _Tuple_impl(allocator_arg_t __tag, const _Alloc& __a,
             const _Tuple_impl& __in)
 : _Base(__use_alloc<_Head, _Alloc, _Head>(__a), _M_head(__in)) { }
      template<typename _Alloc>
 _Tuple_impl(allocator_arg_t __tag, const _Alloc& __a,
             _Tuple_impl&& __in)
 : _Base(__use_alloc<_Head, _Alloc, _Head>(__a),
         std::forward<_Head>(_M_head(__in))) { }
      template<typename _Alloc, typename _UHead>
 _Tuple_impl(allocator_arg_t __tag, const _Alloc& __a,
             const _Tuple_impl<_Idx, _UHead>& __in)
 : _Base(__use_alloc<_Head, _Alloc, _Head>(__a),
  _Tuple_impl<_Idx, _UHead>::_M_head(__in)) { }
      template<typename _Alloc, typename _UHead>
 _Tuple_impl(allocator_arg_t __tag, const _Alloc& __a,
             _Tuple_impl<_Idx, _UHead>&& __in)
 : _Base(__use_alloc<_Head, _Alloc, _UHead>(__a),
                std::forward<_UHead>(_Tuple_impl<_Idx, _UHead>::_M_head(__in)))
 { }
      _Tuple_impl&
      operator=(const _Tuple_impl& __in)
      {
 _M_head(*this) = _M_head(__in);
 return *this;
      }
      _Tuple_impl&
      operator=(_Tuple_impl&& __in)
      noexcept(is_nothrow_move_assignable<_Head>::value)
      {
 _M_head(*this) = std::forward<_Head>(_M_head(__in));
 return *this;
      }
      template<typename _UHead>
        _Tuple_impl&
        operator=(const _Tuple_impl<_Idx, _UHead>& __in)
        {
   _M_head(*this) = _Tuple_impl<_Idx, _UHead>::_M_head(__in);
   return *this;
 }
      template<typename _UHead>
        _Tuple_impl&
        operator=(_Tuple_impl<_Idx, _UHead>&& __in)
        {
   _M_head(*this)
     = std::forward<_UHead>(_Tuple_impl<_Idx, _UHead>::_M_head(__in));
   return *this;
 }
    protected:
      void
      _M_swap(_Tuple_impl& __in)
      noexcept(__is_nothrow_swappable<_Head>::value)
      {
 using std::swap;
 swap(_M_head(*this), _M_head(__in));
      }
    };
  template<bool, typename... _Elements>
  struct _TC
  {
    template<typename... _UElements>
    static constexpr bool _ConstructibleTuple()
    {
      return __and_<is_constructible<_Elements, const _UElements&>...>::value;
    }
    template<typename... _UElements>
    static constexpr bool _ImplicitlyConvertibleTuple()
    {
      return __and_<is_convertible<const _UElements&, _Elements>...>::value;
    }
    template<typename... _UElements>
    static constexpr bool _MoveConstructibleTuple()
    {
      return __and_<is_constructible<_Elements, _UElements&&>...>::value;
    }
    template<typename... _UElements>
    static constexpr bool _ImplicitlyMoveConvertibleTuple()
    {
      return __and_<is_convertible<_UElements&&, _Elements>...>::value;
    }
    template<typename _SrcTuple>
    static constexpr bool _NonNestedTuple()
    {
      return __and_<__not_<is_same<tuple<_Elements...>,
                                   typename remove_cv<
                                     typename remove_reference<_SrcTuple>::type
                                   >::type>>,
                     __not_<is_convertible<_SrcTuple, _Elements...>>,
                     __not_<is_constructible<_Elements..., _SrcTuple>>
              >::value;
    }
    template<typename... _UElements>
    static constexpr bool _NotSameTuple()
    {
      return __not_<is_same<tuple<_Elements...>,
        typename remove_const<
          typename remove_reference<_UElements...>::type
          >::type>>::value;
    }
  };
  template<typename... _Elements>
  struct _TC<false, _Elements...>
  {
    template<typename... _UElements>
    static constexpr bool _ConstructibleTuple()
    {
      return false;
    }
    template<typename... _UElements>
    static constexpr bool _ImplicitlyConvertibleTuple()
    {
      return false;
    }
    template<typename... _UElements>
    static constexpr bool _MoveConstructibleTuple()
    {
      return false;
    }
    template<typename... _UElements>
    static constexpr bool _ImplicitlyMoveConvertibleTuple()
    {
      return false;
    }
    template<typename... _UElements>
    static constexpr bool _NonNestedTuple()
    {
      return true;
    }
    template<typename... _UElements>
    static constexpr bool _NotSameTuple()
    {
      return true;
    }
  };
  template<typename... _Elements>
    class tuple : public _Tuple_impl<0, _Elements...>
    {
      typedef _Tuple_impl<0, _Elements...> _Inherited;
      template<typename _Dummy>
      struct _TC2
      {
        static constexpr bool _DefaultConstructibleTuple()
        {
          return __and_<is_default_constructible<_Elements>...>::value;
        }
        static constexpr bool _ImplicitlyDefaultConstructibleTuple()
        {
          return __and_<__is_implicitly_default_constructible<_Elements>...>
            ::value;
        }
      };
    public:
      template<typename _Dummy = void,
               typename enable_if<_TC2<_Dummy>::
                                    _ImplicitlyDefaultConstructibleTuple(),
                                  bool>::type = true>
      constexpr tuple()
      : _Inherited() { }
      template<typename _Dummy = void,
               typename enable_if<_TC2<_Dummy>::
                                    _DefaultConstructibleTuple()
                                  &&
                                  !_TC2<_Dummy>::
                                    _ImplicitlyDefaultConstructibleTuple(),
                                  bool>::type = false>
      explicit constexpr tuple()
      : _Inherited() { }
      template<typename _Dummy> using _TCC =
        _TC<is_same<_Dummy, void>::value,
            _Elements...>;
      template<typename _Dummy = void,
               typename enable_if<
                 _TCC<_Dummy>::template
                   _ConstructibleTuple<_Elements...>()
                 && _TCC<_Dummy>::template
                   _ImplicitlyConvertibleTuple<_Elements...>()
                 && (sizeof...(_Elements) >= 1),
               bool>::type=true>
        constexpr tuple(const _Elements&... __elements)
      : _Inherited(__elements...) { }
      template<typename _Dummy = void,
               typename enable_if<
                 _TCC<_Dummy>::template
                   _ConstructibleTuple<_Elements...>()
                 && !_TCC<_Dummy>::template
                   _ImplicitlyConvertibleTuple<_Elements...>()
                 && (sizeof...(_Elements) >= 1),
               bool>::type=false>
      explicit constexpr tuple(const _Elements&... __elements)
      : _Inherited(__elements...) { }
      template<typename... _UElements> using _TMC =
                  _TC<(sizeof...(_Elements) == sizeof...(_UElements))
        && (_TC<(sizeof...(_UElements)==1), _Elements...>::
     template _NotSameTuple<_UElements...>()),
                      _Elements...>;
      template<typename... _UElements> using _TMCT =
                  _TC<(sizeof...(_Elements) == sizeof...(_UElements))
        && !is_same<tuple<_Elements...>,
      tuple<_UElements...>>::value,
                      _Elements...>;
      template<typename... _UElements, typename
        enable_if<
    _TMC<_UElements...>::template
                    _MoveConstructibleTuple<_UElements...>()
                  && _TMC<_UElements...>::template
                    _ImplicitlyMoveConvertibleTuple<_UElements...>()
                  && (sizeof...(_Elements) >= 1),
        bool>::type=true>
        constexpr tuple(_UElements&&... __elements)
        : _Inherited(std::forward<_UElements>(__elements)...) { }
      template<typename... _UElements, typename
        enable_if<
    _TMC<_UElements...>::template
                    _MoveConstructibleTuple<_UElements...>()
                  && !_TMC<_UElements...>::template
                    _ImplicitlyMoveConvertibleTuple<_UElements...>()
                  && (sizeof...(_Elements) >= 1),
        bool>::type=false>
        explicit constexpr tuple(_UElements&&... __elements)
 : _Inherited(std::forward<_UElements>(__elements)...) { }
      constexpr tuple(const tuple&) = default;
      constexpr tuple(tuple&&) = default;
      template<typename _Dummy> using _TNTC =
        _TC<is_same<_Dummy, void>::value && sizeof...(_Elements) == 1,
            _Elements...>;
      template<typename... _UElements, typename _Dummy = void, typename
        enable_if<_TMCT<_UElements...>::template
                    _ConstructibleTuple<_UElements...>()
                  && _TMCT<_UElements...>::template
                    _ImplicitlyConvertibleTuple<_UElements...>()
                  && _TNTC<_Dummy>::template
                    _NonNestedTuple<const tuple<_UElements...>&>(),
        bool>::type=true>
        constexpr tuple(const tuple<_UElements...>& __in)
        : _Inherited(static_cast<const _Tuple_impl<0, _UElements...>&>(__in))
        { }
      template<typename... _UElements, typename _Dummy = void, typename
        enable_if<_TMCT<_UElements...>::template
                    _ConstructibleTuple<_UElements...>()
                  && !_TMCT<_UElements...>::template
                    _ImplicitlyConvertibleTuple<_UElements...>()
                  && _TNTC<_Dummy>::template
                    _NonNestedTuple<const tuple<_UElements...>&>(),
        bool>::type=false>
        explicit constexpr tuple(const tuple<_UElements...>& __in)
        : _Inherited(static_cast<const _Tuple_impl<0, _UElements...>&>(__in))
        { }
      template<typename... _UElements, typename _Dummy = void, typename
        enable_if<_TMCT<_UElements...>::template
                    _MoveConstructibleTuple<_UElements...>()
                  && _TMCT<_UElements...>::template
                    _ImplicitlyMoveConvertibleTuple<_UElements...>()
                  && _TNTC<_Dummy>::template
                    _NonNestedTuple<tuple<_UElements...>&&>(),
        bool>::type=true>
        constexpr tuple(tuple<_UElements...>&& __in)
        : _Inherited(static_cast<_Tuple_impl<0, _UElements...>&&>(__in)) { }
      template<typename... _UElements, typename _Dummy = void, typename
        enable_if<_TMCT<_UElements...>::template
                    _MoveConstructibleTuple<_UElements...>()
                  && !_TMCT<_UElements...>::template
                    _ImplicitlyMoveConvertibleTuple<_UElements...>()
                  && _TNTC<_Dummy>::template
                    _NonNestedTuple<tuple<_UElements...>&&>(),
        bool>::type=false>
        explicit constexpr tuple(tuple<_UElements...>&& __in)
        : _Inherited(static_cast<_Tuple_impl<0, _UElements...>&&>(__in)) { }
      template<typename _Alloc>
 tuple(allocator_arg_t __tag, const _Alloc& __a)
 : _Inherited(__tag, __a) { }
      template<typename _Alloc, typename _Dummy = void,
               typename enable_if<
                 _TCC<_Dummy>::template
                   _ConstructibleTuple<_Elements...>()
                 && _TCC<_Dummy>::template
                   _ImplicitlyConvertibleTuple<_Elements...>(),
               bool>::type=true>
 tuple(allocator_arg_t __tag, const _Alloc& __a,
       const _Elements&... __elements)
 : _Inherited(__tag, __a, __elements...) { }
      template<typename _Alloc, typename _Dummy = void,
               typename enable_if<
                 _TCC<_Dummy>::template
                   _ConstructibleTuple<_Elements...>()
                 && !_TCC<_Dummy>::template
                   _ImplicitlyConvertibleTuple<_Elements...>(),
               bool>::type=false>
 explicit tuple(allocator_arg_t __tag, const _Alloc& __a,
                       const _Elements&... __elements)
 : _Inherited(__tag, __a, __elements...) { }
      template<typename _Alloc, typename... _UElements, typename
        enable_if<_TMC<_UElements...>::template
                    _MoveConstructibleTuple<_UElements...>()
                  && _TMC<_UElements...>::template
                    _ImplicitlyMoveConvertibleTuple<_UElements...>(),
        bool>::type=true>
 tuple(allocator_arg_t __tag, const _Alloc& __a,
       _UElements&&... __elements)
 : _Inherited(__tag, __a, std::forward<_UElements>(__elements)...)
        { }
      template<typename _Alloc, typename... _UElements, typename
        enable_if<_TMC<_UElements...>::template
                    _MoveConstructibleTuple<_UElements...>()
                  && !_TMC<_UElements...>::template
                    _ImplicitlyMoveConvertibleTuple<_UElements...>(),
        bool>::type=false>
 explicit tuple(allocator_arg_t __tag, const _Alloc& __a,
       _UElements&&... __elements)
 : _Inherited(__tag, __a, std::forward<_UElements>(__elements)...)
        { }
      template<typename _Alloc>
 tuple(allocator_arg_t __tag, const _Alloc& __a, const tuple& __in)
 : _Inherited(__tag, __a, static_cast<const _Inherited&>(__in)) { }
      template<typename _Alloc>
 tuple(allocator_arg_t __tag, const _Alloc& __a, tuple&& __in)
 : _Inherited(__tag, __a, static_cast<_Inherited&&>(__in)) { }
      template<typename _Alloc, typename _Dummy = void,
        typename... _UElements, typename
        enable_if<_TMCT<_UElements...>::template
                    _ConstructibleTuple<_UElements...>()
                  && _TMCT<_UElements...>::template
                    _ImplicitlyConvertibleTuple<_UElements...>()
                  && _TNTC<_Dummy>::template
                    _NonNestedTuple<tuple<_UElements...>&&>(),
        bool>::type=true>
 tuple(allocator_arg_t __tag, const _Alloc& __a,
       const tuple<_UElements...>& __in)
 : _Inherited(__tag, __a,
              static_cast<const _Tuple_impl<0, _UElements...>&>(__in))
 { }
      template<typename _Alloc, typename _Dummy = void,
        typename... _UElements, typename
        enable_if<_TMCT<_UElements...>::template
                    _ConstructibleTuple<_UElements...>()
                  && !_TMCT<_UElements...>::template
                    _ImplicitlyConvertibleTuple<_UElements...>()
                  && _TNTC<_Dummy>::template
                    _NonNestedTuple<tuple<_UElements...>&&>(),
        bool>::type=false>
 explicit tuple(allocator_arg_t __tag, const _Alloc& __a,
       const tuple<_UElements...>& __in)
 : _Inherited(__tag, __a,
              static_cast<const _Tuple_impl<0, _UElements...>&>(__in))
 { }
      template<typename _Alloc, typename _Dummy = void,
        typename... _UElements, typename
        enable_if<_TMCT<_UElements...>::template
                    _MoveConstructibleTuple<_UElements...>()
                  && _TMCT<_UElements...>::template
                    _ImplicitlyMoveConvertibleTuple<_UElements...>()
                  && _TNTC<_Dummy>::template
                    _NonNestedTuple<tuple<_UElements...>&&>(),
        bool>::type=true>
 tuple(allocator_arg_t __tag, const _Alloc& __a,
       tuple<_UElements...>&& __in)
 : _Inherited(__tag, __a,
              static_cast<_Tuple_impl<0, _UElements...>&&>(__in))
 { }
      template<typename _Alloc, typename _Dummy = void,
        typename... _UElements, typename
        enable_if<_TMCT<_UElements...>::template
                    _MoveConstructibleTuple<_UElements...>()
                  && !_TMCT<_UElements...>::template
                    _ImplicitlyMoveConvertibleTuple<_UElements...>()
                  && _TNTC<_Dummy>::template
                    _NonNestedTuple<tuple<_UElements...>&&>(),
        bool>::type=false>
 explicit tuple(allocator_arg_t __tag, const _Alloc& __a,
       tuple<_UElements...>&& __in)
 : _Inherited(__tag, __a,
              static_cast<_Tuple_impl<0, _UElements...>&&>(__in))
 { }
      tuple&
      operator=(const tuple& __in)
      {
 static_cast<_Inherited&>(*this) = __in;
 return *this;
      }
      tuple&
      operator=(tuple&& __in)
      noexcept(is_nothrow_move_assignable<_Inherited>::value)
      {
 static_cast<_Inherited&>(*this) = std::move(__in);
 return *this;
      }
      template<typename... _UElements>
 typename
        enable_if<sizeof...(_UElements)
    == sizeof...(_Elements), tuple&>::type
        operator=(const tuple<_UElements...>& __in)
        {
   static_cast<_Inherited&>(*this) = __in;
   return *this;
 }
      template<typename... _UElements>
 typename
        enable_if<sizeof...(_UElements)
    == sizeof...(_Elements), tuple&>::type
        operator=(tuple<_UElements...>&& __in)
        {
   static_cast<_Inherited&>(*this) = std::move(__in);
   return *this;
 }
      void
      swap(tuple& __in)
      noexcept(noexcept(__in._M_swap(__in)))
      { _Inherited::_M_swap(__in); }
    };
  template<>
    class tuple<>
    {
    public:
      void swap(tuple&) noexcept { }
      tuple() = default;
      template<typename _Alloc>
 tuple(allocator_arg_t, const _Alloc&) { }
      template<typename _Alloc>
 tuple(allocator_arg_t, const _Alloc&, const tuple&) { }
    };
  template<typename _T1, typename _T2>
    class tuple<_T1, _T2> : public _Tuple_impl<0, _T1, _T2>
    {
      typedef _Tuple_impl<0, _T1, _T2> _Inherited;
    public:
      template <typename _U1 = _T1,
                typename _U2 = _T2,
                typename enable_if<__and_<
                                     __is_implicitly_default_constructible<_U1>,
                                     __is_implicitly_default_constructible<_U2>>
                                   ::value, bool>::type = true>
      constexpr tuple()
      : _Inherited() { }
      template <typename _U1 = _T1,
                typename _U2 = _T2,
                typename enable_if<
                  __and_<
                    is_default_constructible<_U1>,
                    is_default_constructible<_U2>,
                    __not_<
                      __and_<__is_implicitly_default_constructible<_U1>,
                             __is_implicitly_default_constructible<_U2>>>>
                  ::value, bool>::type = false>
      explicit constexpr tuple()
      : _Inherited() { }
      template<typename _Dummy> using _TCC =
        _TC<is_same<_Dummy, void>::value, _T1, _T2>;
      template<typename _Dummy = void, typename
               enable_if<_TCC<_Dummy>::template
                           _ConstructibleTuple<_T1, _T2>()
                         && _TCC<_Dummy>::template
                           _ImplicitlyConvertibleTuple<_T1, _T2>(),
 bool>::type = true>
        constexpr tuple(const _T1& __a1, const _T2& __a2)
        : _Inherited(__a1, __a2) { }
      template<typename _Dummy = void, typename
               enable_if<_TCC<_Dummy>::template
                           _ConstructibleTuple<_T1, _T2>()
                         && !_TCC<_Dummy>::template
                           _ImplicitlyConvertibleTuple<_T1, _T2>(),
 bool>::type = false>
        explicit constexpr tuple(const _T1& __a1, const _T2& __a2)
        : _Inherited(__a1, __a2) { }
      using _TMC = _TC<true, _T1, _T2>;
      template<typename _U1, typename _U2, typename
        enable_if<_TMC::template
                    _MoveConstructibleTuple<_U1, _U2>()
                  && _TMC::template
                    _ImplicitlyMoveConvertibleTuple<_U1, _U2>()
           && !is_same<typename decay<_U1>::type,
         allocator_arg_t>::value,
 bool>::type = true>
        constexpr tuple(_U1&& __a1, _U2&& __a2)
 : _Inherited(std::forward<_U1>(__a1), std::forward<_U2>(__a2)) { }
      template<typename _U1, typename _U2, typename
        enable_if<_TMC::template
                    _MoveConstructibleTuple<_U1, _U2>()
                  && !_TMC::template
                    _ImplicitlyMoveConvertibleTuple<_U1, _U2>()
           && !is_same<typename decay<_U1>::type,
         allocator_arg_t>::value,
 bool>::type = false>
        explicit constexpr tuple(_U1&& __a1, _U2&& __a2)
 : _Inherited(std::forward<_U1>(__a1), std::forward<_U2>(__a2)) { }
      constexpr tuple(const tuple&) = default;
      constexpr tuple(tuple&&) = default;
      template<typename _U1, typename _U2, typename
        enable_if<_TMC::template
                    _ConstructibleTuple<_U1, _U2>()
                  && _TMC::template
                    _ImplicitlyConvertibleTuple<_U1, _U2>(),
 bool>::type = true>
        constexpr tuple(const tuple<_U1, _U2>& __in)
 : _Inherited(static_cast<const _Tuple_impl<0, _U1, _U2>&>(__in)) { }
      template<typename _U1, typename _U2, typename
        enable_if<_TMC::template
                    _ConstructibleTuple<_U1, _U2>()
                  && !_TMC::template
                    _ImplicitlyConvertibleTuple<_U1, _U2>(),
 bool>::type = false>
        explicit constexpr tuple(const tuple<_U1, _U2>& __in)
 : _Inherited(static_cast<const _Tuple_impl<0, _U1, _U2>&>(__in)) { }
      template<typename _U1, typename _U2, typename
        enable_if<_TMC::template
                    _MoveConstructibleTuple<_U1, _U2>()
                  && _TMC::template
                    _ImplicitlyMoveConvertibleTuple<_U1, _U2>(),
 bool>::type = true>
        constexpr tuple(tuple<_U1, _U2>&& __in)
 : _Inherited(static_cast<_Tuple_impl<0, _U1, _U2>&&>(__in)) { }
      template<typename _U1, typename _U2, typename
        enable_if<_TMC::template
                    _MoveConstructibleTuple<_U1, _U2>()
                  && !_TMC::template
                    _ImplicitlyMoveConvertibleTuple<_U1, _U2>(),
 bool>::type = false>
        explicit constexpr tuple(tuple<_U1, _U2>&& __in)
 : _Inherited(static_cast<_Tuple_impl<0, _U1, _U2>&&>(__in)) { }
      template<typename _U1, typename _U2, typename
        enable_if<_TMC::template
                    _ConstructibleTuple<_U1, _U2>()
                  && _TMC::template
                    _ImplicitlyConvertibleTuple<_U1, _U2>(),
 bool>::type = true>
        constexpr tuple(const pair<_U1, _U2>& __in)
 : _Inherited(__in.first, __in.second) { }
      template<typename _U1, typename _U2, typename
        enable_if<_TMC::template
                    _ConstructibleTuple<_U1, _U2>()
                  && !_TMC::template
                    _ImplicitlyConvertibleTuple<_U1, _U2>(),
 bool>::type = false>
        explicit constexpr tuple(const pair<_U1, _U2>& __in)
 : _Inherited(__in.first, __in.second) { }
      template<typename _U1, typename _U2, typename
        enable_if<_TMC::template
                    _MoveConstructibleTuple<_U1, _U2>()
                  && _TMC::template
                    _ImplicitlyMoveConvertibleTuple<_U1, _U2>(),
 bool>::type = true>
        constexpr tuple(pair<_U1, _U2>&& __in)
 : _Inherited(std::forward<_U1>(__in.first),
       std::forward<_U2>(__in.second)) { }
      template<typename _U1, typename _U2, typename
        enable_if<_TMC::template
                    _MoveConstructibleTuple<_U1, _U2>()
                  && !_TMC::template
                    _ImplicitlyMoveConvertibleTuple<_U1, _U2>(),
 bool>::type = false>
        explicit constexpr tuple(pair<_U1, _U2>&& __in)
 : _Inherited(std::forward<_U1>(__in.first),
       std::forward<_U2>(__in.second)) { }
      template<typename _Alloc>
 tuple(allocator_arg_t __tag, const _Alloc& __a)
 : _Inherited(__tag, __a) { }
      template<typename _Alloc, typename _Dummy = void,
               typename enable_if<
                 _TCC<_Dummy>::template
                   _ConstructibleTuple<_T1, _T2>()
                 && _TCC<_Dummy>::template
                   _ImplicitlyConvertibleTuple<_T1, _T2>(),
               bool>::type=true>
 tuple(allocator_arg_t __tag, const _Alloc& __a,
       const _T1& __a1, const _T2& __a2)
 : _Inherited(__tag, __a, __a1, __a2) { }
      template<typename _Alloc, typename _Dummy = void,
               typename enable_if<
                 _TCC<_Dummy>::template
                   _ConstructibleTuple<_T1, _T2>()
                 && !_TCC<_Dummy>::template
                   _ImplicitlyConvertibleTuple<_T1, _T2>(),
               bool>::type=false>
 explicit tuple(allocator_arg_t __tag, const _Alloc& __a,
       const _T1& __a1, const _T2& __a2)
 : _Inherited(__tag, __a, __a1, __a2) { }
      template<typename _Alloc, typename _U1, typename _U2, typename
        enable_if<_TMC::template
                    _MoveConstructibleTuple<_U1, _U2>()
                  && _TMC::template
                    _ImplicitlyMoveConvertibleTuple<_U1, _U2>(),
 bool>::type = true>
 tuple(allocator_arg_t __tag, const _Alloc& __a, _U1&& __a1, _U2&& __a2)
 : _Inherited(__tag, __a, std::forward<_U1>(__a1),
              std::forward<_U2>(__a2)) { }
      template<typename _Alloc, typename _U1, typename _U2, typename
        enable_if<_TMC::template
                    _MoveConstructibleTuple<_U1, _U2>()
                  && !_TMC::template
                    _ImplicitlyMoveConvertibleTuple<_U1, _U2>(),
 bool>::type = false>
 explicit tuple(allocator_arg_t __tag, const _Alloc& __a,
                       _U1&& __a1, _U2&& __a2)
 : _Inherited(__tag, __a, std::forward<_U1>(__a1),
              std::forward<_U2>(__a2)) { }
      template<typename _Alloc>
 tuple(allocator_arg_t __tag, const _Alloc& __a, const tuple& __in)
 : _Inherited(__tag, __a, static_cast<const _Inherited&>(__in)) { }
      template<typename _Alloc>
 tuple(allocator_arg_t __tag, const _Alloc& __a, tuple&& __in)
 : _Inherited(__tag, __a, static_cast<_Inherited&&>(__in)) { }
      template<typename _Alloc, typename _U1, typename _U2, typename
        enable_if<_TMC::template
                    _ConstructibleTuple<_U1, _U2>()
                  && _TMC::template
                    _ImplicitlyConvertibleTuple<_U1, _U2>(),
 bool>::type = true>
 tuple(allocator_arg_t __tag, const _Alloc& __a,
       const tuple<_U1, _U2>& __in)
 : _Inherited(__tag, __a,
              static_cast<const _Tuple_impl<0, _U1, _U2>&>(__in))
 { }
      template<typename _Alloc, typename _U1, typename _U2, typename
        enable_if<_TMC::template
                    _ConstructibleTuple<_U1, _U2>()
                  && !_TMC::template
                    _ImplicitlyConvertibleTuple<_U1, _U2>(),
 bool>::type = false>
 explicit tuple(allocator_arg_t __tag, const _Alloc& __a,
       const tuple<_U1, _U2>& __in)
 : _Inherited(__tag, __a,
              static_cast<const _Tuple_impl<0, _U1, _U2>&>(__in))
 { }
      template<typename _Alloc, typename _U1, typename _U2, typename
        enable_if<_TMC::template
                    _MoveConstructibleTuple<_U1, _U2>()
                  && _TMC::template
                    _ImplicitlyMoveConvertibleTuple<_U1, _U2>(),
 bool>::type = true>
 tuple(allocator_arg_t __tag, const _Alloc& __a, tuple<_U1, _U2>&& __in)
 : _Inherited(__tag, __a, static_cast<_Tuple_impl<0, _U1, _U2>&&>(__in))
 { }
      template<typename _Alloc, typename _U1, typename _U2, typename
        enable_if<_TMC::template
                    _MoveConstructibleTuple<_U1, _U2>()
                  && !_TMC::template
                    _ImplicitlyMoveConvertibleTuple<_U1, _U2>(),
 bool>::type = false>
 explicit tuple(allocator_arg_t __tag, const _Alloc& __a,
                       tuple<_U1, _U2>&& __in)
 : _Inherited(__tag, __a, static_cast<_Tuple_impl<0, _U1, _U2>&&>(__in))
 { }
      template<typename _Alloc, typename _U1, typename _U2, typename
        enable_if<_TMC::template
                    _ConstructibleTuple<_U1, _U2>()
                  && _TMC::template
                    _ImplicitlyConvertibleTuple<_U1, _U2>(),
 bool>::type = true>
        tuple(allocator_arg_t __tag, const _Alloc& __a,
       const pair<_U1, _U2>& __in)
 : _Inherited(__tag, __a, __in.first, __in.second) { }
      template<typename _Alloc, typename _U1, typename _U2, typename
        enable_if<_TMC::template
                    _ConstructibleTuple<_U1, _U2>()
                  && !_TMC::template
                    _ImplicitlyConvertibleTuple<_U1, _U2>(),
 bool>::type = false>
        explicit tuple(allocator_arg_t __tag, const _Alloc& __a,
       const pair<_U1, _U2>& __in)
 : _Inherited(__tag, __a, __in.first, __in.second) { }
      template<typename _Alloc, typename _U1, typename _U2, typename
        enable_if<_TMC::template
                    _MoveConstructibleTuple<_U1, _U2>()
                  && _TMC::template
                    _ImplicitlyMoveConvertibleTuple<_U1, _U2>(),
 bool>::type = true>
        tuple(allocator_arg_t __tag, const _Alloc& __a, pair<_U1, _U2>&& __in)
 : _Inherited(__tag, __a, std::forward<_U1>(__in.first),
       std::forward<_U2>(__in.second)) { }
      template<typename _Alloc, typename _U1, typename _U2, typename
        enable_if<_TMC::template
                    _MoveConstructibleTuple<_U1, _U2>()
                  && !_TMC::template
                    _ImplicitlyMoveConvertibleTuple<_U1, _U2>(),
 bool>::type = false>
        explicit tuple(allocator_arg_t __tag, const _Alloc& __a,
                       pair<_U1, _U2>&& __in)
 : _Inherited(__tag, __a, std::forward<_U1>(__in.first),
       std::forward<_U2>(__in.second)) { }
      tuple&
      operator=(const tuple& __in)
      {
 static_cast<_Inherited&>(*this) = __in;
 return *this;
      }
      tuple&
      operator=(tuple&& __in)
      noexcept(is_nothrow_move_assignable<_Inherited>::value)
      {
 static_cast<_Inherited&>(*this) = std::move(__in);
 return *this;
      }
      template<typename _U1, typename _U2>
        tuple&
        operator=(const tuple<_U1, _U2>& __in)
        {
   static_cast<_Inherited&>(*this) = __in;
   return *this;
 }
      template<typename _U1, typename _U2>
        tuple&
        operator=(tuple<_U1, _U2>&& __in)
        {
   static_cast<_Inherited&>(*this) = std::move(__in);
   return *this;
 }
      template<typename _U1, typename _U2>
        tuple&
        operator=(const pair<_U1, _U2>& __in)
        {
   this->_M_head(*this) = __in.first;
   this->_M_tail(*this)._M_head(*this) = __in.second;
   return *this;
 }
      template<typename _U1, typename _U2>
        tuple&
        operator=(pair<_U1, _U2>&& __in)
        {
   this->_M_head(*this) = std::forward<_U1>(__in.first);
   this->_M_tail(*this)._M_head(*this) = std::forward<_U2>(__in.second);
   return *this;
 }
      void
      swap(tuple& __in)
      noexcept(noexcept(__in._M_swap(__in)))
      { _Inherited::_M_swap(__in); }
    };
  template<typename... _Elements>
    struct tuple_size<tuple<_Elements...>>
    : public integral_constant<std::size_t, sizeof...(_Elements)> { };
  template<std::size_t __i, typename _Head, typename... _Tail>
    struct tuple_element<__i, tuple<_Head, _Tail...> >
    : tuple_element<__i - 1, tuple<_Tail...> > { };
  template<typename _Head, typename... _Tail>
    struct tuple_element<0, tuple<_Head, _Tail...> >
    {
      typedef _Head type;
    };
  template<size_t __i>
    struct tuple_element<__i, tuple<>>
    {
      static_assert(__i < tuple_size<tuple<>>::value,
   "tuple index is in range");
    };
  template<std::size_t __i, typename _Head, typename... _Tail>
    constexpr _Head&
    __get_helper(_Tuple_impl<__i, _Head, _Tail...>& __t) noexcept
    { return _Tuple_impl<__i, _Head, _Tail...>::_M_head(__t); }
  template<std::size_t __i, typename _Head, typename... _Tail>
    constexpr const _Head&
    __get_helper(const _Tuple_impl<__i, _Head, _Tail...>& __t) noexcept
    { return _Tuple_impl<__i, _Head, _Tail...>::_M_head(__t); }
  template<std::size_t __i, typename... _Elements>
    constexpr __tuple_element_t<__i, tuple<_Elements...>>&
    get(tuple<_Elements...>& __t) noexcept
    { return std::__get_helper<__i>(__t); }
  template<std::size_t __i, typename... _Elements>
    constexpr const __tuple_element_t<__i, tuple<_Elements...>>&
    get(const tuple<_Elements...>& __t) noexcept
    { return std::__get_helper<__i>(__t); }
  template<std::size_t __i, typename... _Elements>
    constexpr __tuple_element_t<__i, tuple<_Elements...>>&&
    get(tuple<_Elements...>&& __t) noexcept
    {
      typedef __tuple_element_t<__i, tuple<_Elements...>> __element_type;
      return std::forward<__element_type&&>(std::get<__i>(__t));
    }
  template<std::size_t __i, typename... _Elements>
    constexpr const __tuple_element_t<__i, tuple<_Elements...>>&&
    get(const tuple<_Elements...>&& __t) noexcept
    {
      typedef __tuple_element_t<__i, tuple<_Elements...>> __element_type;
      return std::forward<const __element_type&&>(std::get<__i>(__t));
    }
  template<typename _Head, size_t __i, typename... _Tail>
    constexpr _Head&
    __get_helper2(_Tuple_impl<__i, _Head, _Tail...>& __t) noexcept
    { return _Tuple_impl<__i, _Head, _Tail...>::_M_head(__t); }
  template<typename _Head, size_t __i, typename... _Tail>
    constexpr const _Head&
    __get_helper2(const _Tuple_impl<__i, _Head, _Tail...>& __t) noexcept
    { return _Tuple_impl<__i, _Head, _Tail...>::_M_head(__t); }
  template <typename _Tp, typename... _Types>
    constexpr _Tp&
    get(tuple<_Types...>& __t) noexcept
    { return std::__get_helper2<_Tp>(__t); }
  template <typename _Tp, typename... _Types>
    constexpr _Tp&&
    get(tuple<_Types...>&& __t) noexcept
    { return std::forward<_Tp&&>(std::__get_helper2<_Tp>(__t)); }
  template <typename _Tp, typename... _Types>
    constexpr const _Tp&
    get(const tuple<_Types...>& __t) noexcept
    { return std::__get_helper2<_Tp>(__t); }
  template <typename _Tp, typename... _Types>
    constexpr const _Tp&&
    get(const tuple<_Types...>&& __t) noexcept
    { return std::forward<const _Tp&&>(std::__get_helper2<_Tp>(__t)); }
  template<typename _Tp, typename _Up, size_t __i, size_t __size>
    struct __tuple_compare
    {
      static constexpr bool
      __eq(const _Tp& __t, const _Up& __u)
      {
 return bool(std::get<__i>(__t) == std::get<__i>(__u))
   && __tuple_compare<_Tp, _Up, __i + 1, __size>::__eq(__t, __u);
      }
      static constexpr bool
      __less(const _Tp& __t, const _Up& __u)
      {
 return bool(std::get<__i>(__t) < std::get<__i>(__u))
   || (!bool(std::get<__i>(__u) < std::get<__i>(__t))
       && __tuple_compare<_Tp, _Up, __i + 1, __size>::__less(__t, __u));
      }
    };
  template<typename _Tp, typename _Up, size_t __size>
    struct __tuple_compare<_Tp, _Up, __size, __size>
    {
      static constexpr bool
      __eq(const _Tp&, const _Up&) { return true; }
      static constexpr bool
      __less(const _Tp&, const _Up&) { return false; }
    };
  template<typename... _TElements, typename... _UElements>
    constexpr bool
    operator==(const tuple<_TElements...>& __t,
        const tuple<_UElements...>& __u)
    {
      static_assert(sizeof...(_TElements) == sizeof...(_UElements),
   "tuple objects can only be compared if they have equal sizes.");
      using __compare = __tuple_compare<tuple<_TElements...>,
     tuple<_UElements...>,
     0, sizeof...(_TElements)>;
      return __compare::__eq(__t, __u);
    }
  template<typename... _TElements, typename... _UElements>
    constexpr bool
    operator<(const tuple<_TElements...>& __t,
       const tuple<_UElements...>& __u)
    {
      static_assert(sizeof...(_TElements) == sizeof...(_UElements),
   "tuple objects can only be compared if they have equal sizes.");
      using __compare = __tuple_compare<tuple<_TElements...>,
     tuple<_UElements...>,
     0, sizeof...(_TElements)>;
      return __compare::__less(__t, __u);
    }
  template<typename... _TElements, typename... _UElements>
    constexpr bool
    operator!=(const tuple<_TElements...>& __t,
        const tuple<_UElements...>& __u)
    { return !(__t == __u); }
  template<typename... _TElements, typename... _UElements>
    constexpr bool
    operator>(const tuple<_TElements...>& __t,
       const tuple<_UElements...>& __u)
    { return __u < __t; }
  template<typename... _TElements, typename... _UElements>
    constexpr bool
    operator<=(const tuple<_TElements...>& __t,
        const tuple<_UElements...>& __u)
    { return !(__u < __t); }
  template<typename... _TElements, typename... _UElements>
    constexpr bool
    operator>=(const tuple<_TElements...>& __t,
        const tuple<_UElements...>& __u)
    { return !(__t < __u); }
  template<typename... _Elements>
    constexpr tuple<typename __decay_and_strip<_Elements>::__type...>
    make_tuple(_Elements&&... __args)
    {
      typedef tuple<typename __decay_and_strip<_Elements>::__type...>
 __result_type;
      return __result_type(std::forward<_Elements>(__args)...);
    }
  template<typename... _Elements>
    constexpr tuple<_Elements&&...>
    forward_as_tuple(_Elements&&... __args) noexcept
    { return tuple<_Elements&&...>(std::forward<_Elements>(__args)...); }
  template<size_t, typename, typename, size_t>
    struct __make_tuple_impl;
  template<size_t _Idx, typename _Tuple, typename... _Tp, size_t _Nm>
    struct __make_tuple_impl<_Idx, tuple<_Tp...>, _Tuple, _Nm>
    : __make_tuple_impl<_Idx + 1,
   tuple<_Tp..., __tuple_element_t<_Idx, _Tuple>>,
   _Tuple, _Nm>
    { };
  template<std::size_t _Nm, typename _Tuple, typename... _Tp>
    struct __make_tuple_impl<_Nm, tuple<_Tp...>, _Tuple, _Nm>
    {
      typedef tuple<_Tp...> __type;
    };
  template<typename _Tuple>
    struct __do_make_tuple
    : __make_tuple_impl<0, tuple<>, _Tuple, std::tuple_size<_Tuple>::value>
    { };
  template<typename _Tuple>
    struct __make_tuple
    : public __do_make_tuple<typename std::remove_cv
            <typename std::remove_reference<_Tuple>::type>::type>
    { };
  template<typename...>
    struct __combine_tuples;
  template<>
    struct __combine_tuples<>
    {
      typedef tuple<> __type;
    };
  template<typename... _Ts>
    struct __combine_tuples<tuple<_Ts...>>
    {
      typedef tuple<_Ts...> __type;
    };
  template<typename... _T1s, typename... _T2s, typename... _Rem>
    struct __combine_tuples<tuple<_T1s...>, tuple<_T2s...>, _Rem...>
    {
      typedef typename __combine_tuples<tuple<_T1s..., _T2s...>,
     _Rem...>::__type __type;
    };
  template<typename... _Tpls>
    struct __tuple_cat_result
    {
      typedef typename __combine_tuples
        <typename __make_tuple<_Tpls>::__type...>::__type __type;
    };
  template<typename...>
    struct __make_1st_indices;
  template<>
    struct __make_1st_indices<>
    {
      typedef std::_Index_tuple<> __type;
    };
  template<typename _Tp, typename... _Tpls>
    struct __make_1st_indices<_Tp, _Tpls...>
    {
      typedef typename std::_Build_index_tuple<std::tuple_size<
 typename std::remove_reference<_Tp>::type>::value>::__type __type;
    };
  template<typename _Ret, typename _Indices, typename... _Tpls>
    struct __tuple_concater;
  template<typename _Ret, std::size_t... _Is, typename _Tp, typename... _Tpls>
    struct __tuple_concater<_Ret, std::_Index_tuple<_Is...>, _Tp, _Tpls...>
    {
      template<typename... _Us>
        static constexpr _Ret
        _S_do(_Tp&& __tp, _Tpls&&... __tps, _Us&&... __us)
        {
   typedef typename __make_1st_indices<_Tpls...>::__type __idx;
   typedef __tuple_concater<_Ret, __idx, _Tpls...> __next;
   return __next::_S_do(std::forward<_Tpls>(__tps)...,
          std::forward<_Us>(__us)...,
          std::get<_Is>(std::forward<_Tp>(__tp))...);
 }
    };
  template<typename _Ret>
    struct __tuple_concater<_Ret, std::_Index_tuple<>>
    {
      template<typename... _Us>
 static constexpr _Ret
 _S_do(_Us&&... __us)
        {
   return _Ret(std::forward<_Us>(__us)...);
 }
    };
  template<typename... _Tpls, typename = typename
           enable_if<__and_<__is_tuple_like<_Tpls>...>::value>::type>
    constexpr auto
    tuple_cat(_Tpls&&... __tpls)
    -> typename __tuple_cat_result<_Tpls...>::__type
    {
      typedef typename __tuple_cat_result<_Tpls...>::__type __ret;
      typedef typename __make_1st_indices<_Tpls...>::__type __idx;
      typedef __tuple_concater<__ret, __idx, _Tpls...> __concater;
      return __concater::_S_do(std::forward<_Tpls>(__tpls)...);
    }
  template<typename... _Elements>
    constexpr tuple<_Elements&...>
    tie(_Elements&... __args) noexcept
    { return tuple<_Elements&...>(__args...); }
  template<typename... _Elements>
    inline
    typename enable_if<__and_<__is_swappable<_Elements>...>::value
      >::type
    swap(tuple<_Elements...>& __x, tuple<_Elements...>& __y)
    noexcept(noexcept(__x.swap(__y)))
    { __x.swap(__y); }
  template<typename... _Elements>
    typename enable_if<!__and_<__is_swappable<_Elements>...>::value>::type
    swap(tuple<_Elements...>&, tuple<_Elements...>&) = delete;
  struct _Swallow_assign
  {
    template<class _Tp>
      constexpr const _Swallow_assign&
      operator=(const _Tp&) const
      { return *this; }
  };
  constexpr _Swallow_assign ignore{};
  template<typename... _Types, typename _Alloc>
    struct uses_allocator<tuple<_Types...>, _Alloc> : true_type { };
  template<class _T1, class _T2>
    template<typename... _Args1, typename... _Args2>
      inline
      pair<_T1, _T2>::
      pair(piecewise_construct_t,
    tuple<_Args1...> __first, tuple<_Args2...> __second)
      : pair(__first, __second,
      typename _Build_index_tuple<sizeof...(_Args1)>::__type(),
      typename _Build_index_tuple<sizeof...(_Args2)>::__type())
      { }
  template<class _T1, class _T2>
    template<typename... _Args1, std::size_t... _Indexes1,
             typename... _Args2, std::size_t... _Indexes2>
      inline
      pair<_T1, _T2>::
      pair(tuple<_Args1...>& __tuple1, tuple<_Args2...>& __tuple2,
    _Index_tuple<_Indexes1...>, _Index_tuple<_Indexes2...>)
      : first(std::forward<_Args1>(std::get<_Indexes1>(__tuple1))...),
        second(std::forward<_Args2>(std::get<_Indexes2>(__tuple2))...)
      { }

}
namespace std
{

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
  template<typename> class auto_ptr;
#pragma GCC diagnostic pop
  template<typename _Tp>
    struct default_delete
    {
      constexpr default_delete() noexcept = default;
      template<typename _Up, typename = typename
        enable_if<is_convertible<_Up*, _Tp*>::value>::type>
        default_delete(const default_delete<_Up>&) noexcept { }
      void
      operator()(_Tp* __ptr) const
      {
 static_assert(!is_void<_Tp>::value,
        "can't delete pointer to incomplete type");
 static_assert(sizeof(_Tp)>0,
        "can't delete pointer to incomplete type");
 delete __ptr;
      }
    };
  template<typename _Tp>
    struct default_delete<_Tp[]>
    {
    public:
      constexpr default_delete() noexcept = default;
      template<typename _Up, typename = typename
        enable_if<is_convertible<_Up(*)[], _Tp(*)[]>::value>::type>
        default_delete(const default_delete<_Up[]>&) noexcept { }
      template<typename _Up>
      typename enable_if<is_convertible<_Up(*)[], _Tp(*)[]>::value>::type
 operator()(_Up* __ptr) const
      {
 static_assert(sizeof(_Tp)>0,
        "can't delete pointer to incomplete type");
 delete [] __ptr;
      }
    };
  template <typename _Tp, typename _Dp>
    class __uniq_ptr_impl
    {
      template <typename _Up, typename _Ep, typename = void>
 struct _Ptr
 {
   using type = _Up*;
 };
      template <typename _Up, typename _Ep>
 struct
 _Ptr<_Up, _Ep, __void_t<typename remove_reference<_Ep>::type::pointer>>
 {
   using type = typename remove_reference<_Ep>::type::pointer;
 };
    public:
      using _DeleterConstraint = enable_if<
        __and_<__not_<is_pointer<_Dp>>,
        is_default_constructible<_Dp>>::value>;
      using pointer = typename _Ptr<_Tp, _Dp>::type;
      __uniq_ptr_impl() = default;
      __uniq_ptr_impl(pointer __p) : _M_t() { _M_ptr() = __p; }
      template<typename _Del>
      __uniq_ptr_impl(pointer __p, _Del&& __d)
 : _M_t(__p, std::forward<_Del>(__d)) { }
      pointer& _M_ptr() { return std::get<0>(_M_t); }
      pointer _M_ptr() const { return std::get<0>(_M_t); }
      _Dp& _M_deleter() { return std::get<1>(_M_t); }
      const _Dp& _M_deleter() const { return std::get<1>(_M_t); }
    private:
      tuple<pointer, _Dp> _M_t;
    };
  template <typename _Tp, typename _Dp = default_delete<_Tp>>
    class unique_ptr
    {
      template <class _Up>
      using _DeleterConstraint =
 typename __uniq_ptr_impl<_Tp, _Up>::_DeleterConstraint::type;
      __uniq_ptr_impl<_Tp, _Dp> _M_t;
    public:
      using pointer = typename __uniq_ptr_impl<_Tp, _Dp>::pointer;
      using element_type = _Tp;
      using deleter_type = _Dp;
      template<typename _Up, typename _Ep>
 using __safe_conversion_up = __and_<
         is_convertible<typename unique_ptr<_Up, _Ep>::pointer, pointer>,
                __not_<is_array<_Up>>,
                __or_<__and_<is_reference<deleter_type>,
                             is_same<deleter_type, _Ep>>,
                      __and_<__not_<is_reference<deleter_type>>,
                             is_convertible<_Ep, deleter_type>>
                >
              >;
      template <typename _Up = _Dp,
  typename = _DeleterConstraint<_Up>>
 constexpr unique_ptr() noexcept
 : _M_t()
        { }
      template <typename _Up = _Dp,
  typename = _DeleterConstraint<_Up>>
 explicit
 unique_ptr(pointer __p) noexcept
 : _M_t(__p)
        { }
      unique_ptr(pointer __p,
   typename conditional<is_reference<deleter_type>::value,
     deleter_type, const deleter_type&>::type __d) noexcept
      : _M_t(__p, __d) { }
      unique_ptr(pointer __p,
   typename remove_reference<deleter_type>::type&& __d) noexcept
      : _M_t(std::move(__p), std::move(__d))
      { static_assert(!std::is_reference<deleter_type>::value,
        "rvalue deleter bound to reference"); }
      template <typename _Up = _Dp,
  typename = _DeleterConstraint<_Up>>
 constexpr unique_ptr(nullptr_t) noexcept : unique_ptr() { }
      unique_ptr(unique_ptr&& __u) noexcept
      : _M_t(__u.release(), std::forward<deleter_type>(__u.get_deleter())) { }
      template<typename _Up, typename _Ep, typename = _Require<
               __safe_conversion_up<_Up, _Ep>,
        typename conditional<is_reference<_Dp>::value,
        is_same<_Ep, _Dp>,
        is_convertible<_Ep, _Dp>>::type>>
 unique_ptr(unique_ptr<_Up, _Ep>&& __u) noexcept
 : _M_t(__u.release(), std::forward<_Ep>(__u.get_deleter()))
 { }
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
      template<typename _Up, typename = _Require<
        is_convertible<_Up*, _Tp*>, is_same<_Dp, default_delete<_Tp>>>>
 unique_ptr(auto_ptr<_Up>&& __u) noexcept;
#pragma GCC diagnostic pop
      ~unique_ptr() noexcept
      {
 auto& __ptr = _M_t._M_ptr();
 if (__ptr != nullptr)
   get_deleter()(__ptr);
 __ptr = pointer();
      }
      unique_ptr&
      operator=(unique_ptr&& __u) noexcept
      {
 reset(__u.release());
 get_deleter() = std::forward<deleter_type>(__u.get_deleter());
 return *this;
      }
      template<typename _Up, typename _Ep>
        typename enable_if< __and_<
          __safe_conversion_up<_Up, _Ep>,
          is_assignable<deleter_type&, _Ep&&>
          >::value,
          unique_ptr&>::type
 operator=(unique_ptr<_Up, _Ep>&& __u) noexcept
 {
   reset(__u.release());
   get_deleter() = std::forward<_Ep>(__u.get_deleter());
   return *this;
 }
      unique_ptr&
      operator=(nullptr_t) noexcept
      {
 reset();
 return *this;
      }
      typename add_lvalue_reference<element_type>::type
      operator*() const
      {
 ;
 return *get();
      }
      pointer
      operator->() const noexcept
      {
 ;
 return get();
      }
      pointer
      get() const noexcept
      { return _M_t._M_ptr(); }
      deleter_type&
      get_deleter() noexcept
      { return _M_t._M_deleter(); }
      const deleter_type&
      get_deleter() const noexcept
      { return _M_t._M_deleter(); }
      explicit operator bool() const noexcept
      { return get() == pointer() ? false : true; }
      pointer
      release() noexcept
      {
 pointer __p = get();
 _M_t._M_ptr() = pointer();
 return __p;
      }
      void
      reset(pointer __p = pointer()) noexcept
      {
 using std::swap;
 swap(_M_t._M_ptr(), __p);
 if (__p != pointer())
   get_deleter()(__p);
      }
      void
      swap(unique_ptr& __u) noexcept
      {
 using std::swap;
 swap(_M_t, __u._M_t);
      }
      unique_ptr(const unique_ptr&) = delete;
      unique_ptr& operator=(const unique_ptr&) = delete;
  };
  template<typename _Tp, typename _Dp>
    class unique_ptr<_Tp[], _Dp>
    {
      template <typename _Up>
      using _DeleterConstraint =
 typename __uniq_ptr_impl<_Tp, _Up>::_DeleterConstraint::type;
      __uniq_ptr_impl<_Tp, _Dp> _M_t;
      template<typename _Up>
 using __remove_cv = typename remove_cv<_Up>::type;
      template<typename _Up>
 using __is_derived_Tp
   = __and_< is_base_of<_Tp, _Up>,
      __not_<is_same<__remove_cv<_Tp>, __remove_cv<_Up>>> >;
    public:
      using pointer = typename __uniq_ptr_impl<_Tp, _Dp>::pointer;
      using element_type = _Tp;
      using deleter_type = _Dp;
      template<typename _Up, typename _Ep,
               typename _Up_up = unique_ptr<_Up, _Ep>,
        typename _Up_element_type = typename _Up_up::element_type>
 using __safe_conversion_up = __and_<
          is_array<_Up>,
          is_same<pointer, element_type*>,
          is_same<typename _Up_up::pointer, _Up_element_type*>,
          is_convertible<_Up_element_type(*)[], element_type(*)[]>,
          __or_<__and_<is_reference<deleter_type>, is_same<deleter_type, _Ep>>,
                __and_<__not_<is_reference<deleter_type>>,
                       is_convertible<_Ep, deleter_type>>>
        >;
      template<typename _Up>
        using __safe_conversion_raw = __and_<
          __or_<__or_<is_same<_Up, pointer>,
                      is_same<_Up, nullptr_t>>,
                __and_<is_pointer<_Up>,
                       is_same<pointer, element_type*>,
                       is_convertible<
                         typename remove_pointer<_Up>::type(*)[],
                         element_type(*)[]>
                >
          >
        >;
      template <typename _Up = _Dp,
  typename = _DeleterConstraint<_Up>>
 constexpr unique_ptr() noexcept
 : _M_t()
        { }
      template<typename _Up,
        typename _Vp = _Dp,
        typename = _DeleterConstraint<_Vp>,
        typename = typename enable_if<
                 __safe_conversion_raw<_Up>::value, bool>::type>
 explicit
 unique_ptr(_Up __p) noexcept
 : _M_t(__p)
        { }
      template<typename _Up,
               typename = typename enable_if<
                 __safe_conversion_raw<_Up>::value, bool>::type>
      unique_ptr(_Up __p,
                 typename conditional<is_reference<deleter_type>::value,
                 deleter_type, const deleter_type&>::type __d) noexcept
      : _M_t(__p, __d) { }
      template<typename _Up,
               typename = typename enable_if<
                 __safe_conversion_raw<_Up>::value, bool>::type>
      unique_ptr(_Up __p, typename
   remove_reference<deleter_type>::type&& __d) noexcept
      : _M_t(std::move(__p), std::move(__d))
      { static_assert(!is_reference<deleter_type>::value,
        "rvalue deleter bound to reference"); }
      unique_ptr(unique_ptr&& __u) noexcept
      : _M_t(__u.release(), std::forward<deleter_type>(__u.get_deleter())) { }
      template <typename _Up = _Dp,
  typename = _DeleterConstraint<_Up>>
 constexpr unique_ptr(nullptr_t) noexcept : unique_ptr() { }
      template<typename _Up, typename _Ep,
        typename = _Require<__safe_conversion_up<_Up, _Ep>>>
 unique_ptr(unique_ptr<_Up, _Ep>&& __u) noexcept
 : _M_t(__u.release(), std::forward<_Ep>(__u.get_deleter()))
 { }
      ~unique_ptr()
      {
 auto& __ptr = _M_t._M_ptr();
 if (__ptr != nullptr)
   get_deleter()(__ptr);
 __ptr = pointer();
      }
      unique_ptr&
      operator=(unique_ptr&& __u) noexcept
      {
 reset(__u.release());
 get_deleter() = std::forward<deleter_type>(__u.get_deleter());
 return *this;
      }
      template<typename _Up, typename _Ep>
 typename
 enable_if<__and_<__safe_conversion_up<_Up, _Ep>,
                         is_assignable<deleter_type&, _Ep&&>
                  >::value,
                  unique_ptr&>::type
 operator=(unique_ptr<_Up, _Ep>&& __u) noexcept
 {
   reset(__u.release());
   get_deleter() = std::forward<_Ep>(__u.get_deleter());
   return *this;
 }
      unique_ptr&
      operator=(nullptr_t) noexcept
      {
 reset();
 return *this;
      }
      typename std::add_lvalue_reference<element_type>::type
      operator[](size_t __i) const
      {
 ;
 return get()[__i];
      }
      pointer
      get() const noexcept
      { return _M_t._M_ptr(); }
      deleter_type&
      get_deleter() noexcept
      { return _M_t._M_deleter(); }
      const deleter_type&
      get_deleter() const noexcept
      { return _M_t._M_deleter(); }
      explicit operator bool() const noexcept
      { return get() == pointer() ? false : true; }
      pointer
      release() noexcept
      {
 pointer __p = get();
 _M_t._M_ptr() = pointer();
 return __p;
      }
      template <typename _Up,
                typename = _Require<
                  __or_<is_same<_Up, pointer>,
                        __and_<is_same<pointer, element_type*>,
                               is_pointer<_Up>,
                               is_convertible<
                                 typename remove_pointer<_Up>::type(*)[],
                                 element_type(*)[]
                               >
                        >
                  >
               >>
      void
      reset(_Up __p) noexcept
      {
 pointer __ptr = __p;
 using std::swap;
 swap(_M_t._M_ptr(), __ptr);
 if (__ptr != nullptr)
   get_deleter()(__ptr);
      }
      void reset(nullptr_t = nullptr) noexcept
      {
        reset(pointer());
      }
      void
      swap(unique_ptr& __u) noexcept
      {
 using std::swap;
 swap(_M_t, __u._M_t);
      }
      unique_ptr(const unique_ptr&) = delete;
      unique_ptr& operator=(const unique_ptr&) = delete;
    };
  template<typename _Tp, typename _Dp>
    inline
    typename enable_if<__is_swappable<_Dp>::value>::type
    swap(unique_ptr<_Tp, _Dp>& __x,
  unique_ptr<_Tp, _Dp>& __y) noexcept
    { __x.swap(__y); }
  template<typename _Tp, typename _Dp>
    typename enable_if<!__is_swappable<_Dp>::value>::type
    swap(unique_ptr<_Tp, _Dp>&,
  unique_ptr<_Tp, _Dp>&) = delete;
  template<typename _Tp, typename _Dp,
    typename _Up, typename _Ep>
    inline bool
    operator==(const unique_ptr<_Tp, _Dp>& __x,
        const unique_ptr<_Up, _Ep>& __y)
    { return __x.get() == __y.get(); }
  template<typename _Tp, typename _Dp>
    inline bool
    operator==(const unique_ptr<_Tp, _Dp>& __x, nullptr_t) noexcept
    { return !__x; }
  template<typename _Tp, typename _Dp>
    inline bool
    operator==(nullptr_t, const unique_ptr<_Tp, _Dp>& __x) noexcept
    { return !__x; }
  template<typename _Tp, typename _Dp,
    typename _Up, typename _Ep>
    inline bool
    operator!=(const unique_ptr<_Tp, _Dp>& __x,
        const unique_ptr<_Up, _Ep>& __y)
    { return __x.get() != __y.get(); }
  template<typename _Tp, typename _Dp>
    inline bool
    operator!=(const unique_ptr<_Tp, _Dp>& __x, nullptr_t) noexcept
    { return (bool)__x; }
  template<typename _Tp, typename _Dp>
    inline bool
    operator!=(nullptr_t, const unique_ptr<_Tp, _Dp>& __x) noexcept
    { return (bool)__x; }
  template<typename _Tp, typename _Dp,
    typename _Up, typename _Ep>
    inline bool
    operator<(const unique_ptr<_Tp, _Dp>& __x,
       const unique_ptr<_Up, _Ep>& __y)
    {
      typedef typename
 std::common_type<typename unique_ptr<_Tp, _Dp>::pointer,
                  typename unique_ptr<_Up, _Ep>::pointer>::type _CT;
      return std::less<_CT>()(__x.get(), __y.get());
    }
  template<typename _Tp, typename _Dp>
    inline bool
    operator<(const unique_ptr<_Tp, _Dp>& __x, nullptr_t)
    { return std::less<typename unique_ptr<_Tp, _Dp>::pointer>()(__x.get(),
         nullptr); }
  template<typename _Tp, typename _Dp>
    inline bool
    operator<(nullptr_t, const unique_ptr<_Tp, _Dp>& __x)
    { return std::less<typename unique_ptr<_Tp, _Dp>::pointer>()(nullptr,
         __x.get()); }
  template<typename _Tp, typename _Dp,
    typename _Up, typename _Ep>
    inline bool
    operator<=(const unique_ptr<_Tp, _Dp>& __x,
        const unique_ptr<_Up, _Ep>& __y)
    { return !(__y < __x); }
  template<typename _Tp, typename _Dp>
    inline bool
    operator<=(const unique_ptr<_Tp, _Dp>& __x, nullptr_t)
    { return !(nullptr < __x); }
  template<typename _Tp, typename _Dp>
    inline bool
    operator<=(nullptr_t, const unique_ptr<_Tp, _Dp>& __x)
    { return !(__x < nullptr); }
  template<typename _Tp, typename _Dp,
    typename _Up, typename _Ep>
    inline bool
    operator>(const unique_ptr<_Tp, _Dp>& __x,
       const unique_ptr<_Up, _Ep>& __y)
    { return (__y < __x); }
  template<typename _Tp, typename _Dp>
    inline bool
    operator>(const unique_ptr<_Tp, _Dp>& __x, nullptr_t)
    { return std::less<typename unique_ptr<_Tp, _Dp>::pointer>()(nullptr,
         __x.get()); }
  template<typename _Tp, typename _Dp>
    inline bool
    operator>(nullptr_t, const unique_ptr<_Tp, _Dp>& __x)
    { return std::less<typename unique_ptr<_Tp, _Dp>::pointer>()(__x.get(),
         nullptr); }
  template<typename _Tp, typename _Dp,
    typename _Up, typename _Ep>
    inline bool
    operator>=(const unique_ptr<_Tp, _Dp>& __x,
        const unique_ptr<_Up, _Ep>& __y)
    { return !(__x < __y); }
  template<typename _Tp, typename _Dp>
    inline bool
    operator>=(const unique_ptr<_Tp, _Dp>& __x, nullptr_t)
    { return !(__x < nullptr); }
  template<typename _Tp, typename _Dp>
    inline bool
    operator>=(nullptr_t, const unique_ptr<_Tp, _Dp>& __x)
    { return !(nullptr < __x); }
  template<typename _Tp, typename _Dp>
    struct hash<unique_ptr<_Tp, _Dp>>
    : public __hash_base<size_t, unique_ptr<_Tp, _Dp>>,
    private __poison_hash<typename unique_ptr<_Tp, _Dp>::pointer>
    {
      size_t
      operator()(const unique_ptr<_Tp, _Dp>& __u) const noexcept
      {
 typedef unique_ptr<_Tp, _Dp> _UP;
 return std::hash<typename _UP::pointer>()(__u.get());
      }
    };
  template<typename _Tp>
    struct _MakeUniq
    { typedef unique_ptr<_Tp> __single_object; };
  template<typename _Tp>
    struct _MakeUniq<_Tp[]>
    { typedef unique_ptr<_Tp[]> __array; };
  template<typename _Tp, size_t _Bound>
    struct _MakeUniq<_Tp[_Bound]>
    { struct __invalid_type { }; };
  template<typename _Tp, typename... _Args>
    inline typename _MakeUniq<_Tp>::__single_object
    make_unique(_Args&&... __args)
    { return unique_ptr<_Tp>(new _Tp(std::forward<_Args>(__args)...)); }
  template<typename _Tp>
    inline typename _MakeUniq<_Tp>::__array
    make_unique(size_t __num)
    { return unique_ptr<_Tp>(new remove_extent_t<_Tp>[__num]()); }
  template<typename _Tp, typename... _Args>
    inline typename _MakeUniq<_Tp>::__invalid_type
    make_unique(_Args&&...) = delete;

}
namespace std
{

  template<typename _Alloc>
    struct __allocated_ptr
    {
      using pointer = typename allocator_traits<_Alloc>::pointer;
      using value_type = typename allocator_traits<_Alloc>::value_type;
      __allocated_ptr(_Alloc& __a, pointer __ptr) noexcept
      : _M_alloc(std::__addressof(__a)), _M_ptr(__ptr)
      { }
      template<typename _Ptr,
        typename _Req = _Require<is_same<_Ptr, value_type*>>>
      __allocated_ptr(_Alloc& __a, _Ptr __ptr)
      : _M_alloc(std::__addressof(__a)),
 _M_ptr(pointer_traits<pointer>::pointer_to(*__ptr))
      { }
      __allocated_ptr(__allocated_ptr&& __gd) noexcept
      : _M_alloc(__gd._M_alloc), _M_ptr(__gd._M_ptr)
      { __gd._M_ptr = nullptr; }
      ~__allocated_ptr()
      {
 if (_M_ptr != nullptr)
   std::allocator_traits<_Alloc>::deallocate(*_M_alloc, _M_ptr, 1);
      }
      __allocated_ptr&
      operator=(std::nullptr_t) noexcept
      {
 _M_ptr = nullptr;
 return *this;
      }
      value_type* get() { return std::__to_address(_M_ptr); }
    private:
      _Alloc* _M_alloc;
      pointer _M_ptr;
    };
  template<typename _Alloc>
    __allocated_ptr<_Alloc>
    __allocate_guarded(_Alloc& __a)
    {
      return { __a, std::allocator_traits<_Alloc>::allocate(__a, 1) };
    }

}
       
namespace std
{

  template<typename _Res, typename... _ArgTypes>
    struct _Maybe_unary_or_binary_function { };
  template<typename _Res, typename _T1>
    struct _Maybe_unary_or_binary_function<_Res, _T1>
    : std::unary_function<_T1, _Res> { };
  template<typename _Res, typename _T1, typename _T2>
    struct _Maybe_unary_or_binary_function<_Res, _T1, _T2>
    : std::binary_function<_T1, _T2, _Res> { };
  template<typename _Signature>
    struct _Mem_fn_traits;
  template<typename _Res, typename _Class, typename... _ArgTypes>
    struct _Mem_fn_traits_base
    {
      using __result_type = _Res;
      using __maybe_type
 = _Maybe_unary_or_binary_function<_Res, _Class*, _ArgTypes...>;
      using __arity = integral_constant<size_t, sizeof...(_ArgTypes)>;
    };
template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes...) > : _Mem_fn_traits_base<_Res, _Class, _ArgTypes...> { using __vararg = false_type; }; template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes... ...) > : _Mem_fn_traits_base<_Res, _Class, _ArgTypes...> { using __vararg = true_type; }; template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes...) const > : _Mem_fn_traits_base<_Res, const _Class, _ArgTypes...> { using __vararg = false_type; }; template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes... ...) const > : _Mem_fn_traits_base<_Res, const _Class, _ArgTypes...> { using __vararg = true_type; }; template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes...) volatile > : _Mem_fn_traits_base<_Res, volatile _Class, _ArgTypes...> { using __vararg = false_type; }; template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes... ...) volatile > : _Mem_fn_traits_base<_Res, volatile _Class, _ArgTypes...> { using __vararg = true_type; }; template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes...) const volatile > : _Mem_fn_traits_base<_Res, const volatile _Class, _ArgTypes...> { using __vararg = false_type; }; template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes... ...) const volatile > : _Mem_fn_traits_base<_Res, const volatile _Class, _ArgTypes...> { using __vararg = true_type; };
template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes...) &> : _Mem_fn_traits_base<_Res, _Class, _ArgTypes...> { using __vararg = false_type; }; template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes... ...) &> : _Mem_fn_traits_base<_Res, _Class, _ArgTypes...> { using __vararg = true_type; }; template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes...) const &> : _Mem_fn_traits_base<_Res, const _Class, _ArgTypes...> { using __vararg = false_type; }; template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes... ...) const &> : _Mem_fn_traits_base<_Res, const _Class, _ArgTypes...> { using __vararg = true_type; }; template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes...) volatile &> : _Mem_fn_traits_base<_Res, volatile _Class, _ArgTypes...> { using __vararg = false_type; }; template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes... ...) volatile &> : _Mem_fn_traits_base<_Res, volatile _Class, _ArgTypes...> { using __vararg = true_type; }; template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes...) const volatile &> : _Mem_fn_traits_base<_Res, const volatile _Class, _ArgTypes...> { using __vararg = false_type; }; template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes... ...) const volatile &> : _Mem_fn_traits_base<_Res, const volatile _Class, _ArgTypes...> { using __vararg = true_type; };
template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes...) &&> : _Mem_fn_traits_base<_Res, _Class, _ArgTypes...> { using __vararg = false_type; }; template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes... ...) &&> : _Mem_fn_traits_base<_Res, _Class, _ArgTypes...> { using __vararg = true_type; }; template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes...) const &&> : _Mem_fn_traits_base<_Res, const _Class, _ArgTypes...> { using __vararg = false_type; }; template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes... ...) const &&> : _Mem_fn_traits_base<_Res, const _Class, _ArgTypes...> { using __vararg = true_type; }; template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes...) volatile &&> : _Mem_fn_traits_base<_Res, volatile _Class, _ArgTypes...> { using __vararg = false_type; }; template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes... ...) volatile &&> : _Mem_fn_traits_base<_Res, volatile _Class, _ArgTypes...> { using __vararg = true_type; }; template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes...) const volatile &&> : _Mem_fn_traits_base<_Res, const volatile _Class, _ArgTypes...> { using __vararg = false_type; }; template<typename _Res, typename _Class, typename... _ArgTypes> struct _Mem_fn_traits<_Res (_Class::*)(_ArgTypes... ...) const volatile &&> : _Mem_fn_traits_base<_Res, const volatile _Class, _ArgTypes...> { using __vararg = true_type; };
  template<typename _Functor, typename = __void_t<>>
    struct _Maybe_get_result_type
    { };
  template<typename _Functor>
    struct _Maybe_get_result_type<_Functor,
      __void_t<typename _Functor::result_type>>
    { typedef typename _Functor::result_type result_type; };
  template<typename _Functor>
    struct _Weak_result_type_impl
    : _Maybe_get_result_type<_Functor>
    { };
  template<typename _Res, typename... _ArgTypes >
    struct _Weak_result_type_impl<_Res(_ArgTypes...) >
    { typedef _Res result_type; };
  template<typename _Res, typename... _ArgTypes >
    struct _Weak_result_type_impl<_Res(_ArgTypes......) >
    { typedef _Res result_type; };
  template<typename _Res, typename... _ArgTypes >
    struct _Weak_result_type_impl<_Res(*)(_ArgTypes...) >
    { typedef _Res result_type; };
  template<typename _Res, typename... _ArgTypes >
    struct
    _Weak_result_type_impl<_Res(*)(_ArgTypes......) >
    { typedef _Res result_type; };
  template<typename _Functor,
    bool = is_member_function_pointer<_Functor>::value>
    struct _Weak_result_type_memfun
    : _Weak_result_type_impl<_Functor>
    { };
  template<typename _MemFunPtr>
    struct _Weak_result_type_memfun<_MemFunPtr, true>
    {
      using result_type = typename _Mem_fn_traits<_MemFunPtr>::__result_type;
    };
  template<typename _Func, typename _Class>
    struct _Weak_result_type_memfun<_Func _Class::*, false>
    { };
  template<typename _Functor>
    struct _Weak_result_type
    : _Weak_result_type_memfun<typename remove_cv<_Functor>::type>
    { };
  template<typename _Tp, typename = __void_t<>>
    struct _Refwrap_base_arg1
    { };
  template<typename _Tp>
    struct _Refwrap_base_arg1<_Tp,
         __void_t<typename _Tp::argument_type>>
    {
      typedef typename _Tp::argument_type argument_type;
    };
  template<typename _Tp, typename = __void_t<>>
    struct _Refwrap_base_arg2
    { };
  template<typename _Tp>
    struct _Refwrap_base_arg2<_Tp,
         __void_t<typename _Tp::first_argument_type,
           typename _Tp::second_argument_type>>
    {
      typedef typename _Tp::first_argument_type first_argument_type;
      typedef typename _Tp::second_argument_type second_argument_type;
    };
  template<typename _Tp>
    struct _Reference_wrapper_base
    : _Weak_result_type<_Tp>, _Refwrap_base_arg1<_Tp>, _Refwrap_base_arg2<_Tp>
    { };
  template<typename _Res, typename _T1 >
    struct _Reference_wrapper_base<_Res(_T1) >
    : unary_function<_T1, _Res>
    { };
  template<typename _Res, typename _T1>
    struct _Reference_wrapper_base<_Res(_T1) const>
    : unary_function<_T1, _Res>
    { };
  template<typename _Res, typename _T1>
    struct _Reference_wrapper_base<_Res(_T1) volatile>
    : unary_function<_T1, _Res>
    { };
  template<typename _Res, typename _T1>
    struct _Reference_wrapper_base<_Res(_T1) const volatile>
    : unary_function<_T1, _Res>
    { };
  template<typename _Res, typename _T1, typename _T2 >
    struct _Reference_wrapper_base<_Res(_T1, _T2) >
    : binary_function<_T1, _T2, _Res>
    { };
  template<typename _Res, typename _T1, typename _T2>
    struct _Reference_wrapper_base<_Res(_T1, _T2) const>
    : binary_function<_T1, _T2, _Res>
    { };
  template<typename _Res, typename _T1, typename _T2>
    struct _Reference_wrapper_base<_Res(_T1, _T2) volatile>
    : binary_function<_T1, _T2, _Res>
    { };
  template<typename _Res, typename _T1, typename _T2>
    struct _Reference_wrapper_base<_Res(_T1, _T2) const volatile>
    : binary_function<_T1, _T2, _Res>
    { };
  template<typename _Res, typename _T1 >
    struct _Reference_wrapper_base<_Res(*)(_T1) >
    : unary_function<_T1, _Res>
    { };
  template<typename _Res, typename _T1, typename _T2 >
    struct _Reference_wrapper_base<_Res(*)(_T1, _T2) >
    : binary_function<_T1, _T2, _Res>
    { };
  template<typename _Tp, bool = is_member_function_pointer<_Tp>::value>
    struct _Reference_wrapper_base_memfun
    : _Reference_wrapper_base<_Tp>
    { };
  template<typename _MemFunPtr>
    struct _Reference_wrapper_base_memfun<_MemFunPtr, true>
    : _Mem_fn_traits<_MemFunPtr>::__maybe_type
    {
      using result_type = typename _Mem_fn_traits<_MemFunPtr>::__result_type;
    };
  template<typename _Tp>
    class reference_wrapper
    : public _Reference_wrapper_base_memfun<typename remove_cv<_Tp>::type>
    {
      _Tp* _M_data;
    public:
      typedef _Tp type;
      reference_wrapper(_Tp& __indata) noexcept
      : _M_data(std::__addressof(__indata))
      { }
      reference_wrapper(_Tp&&) = delete;
      reference_wrapper(const reference_wrapper&) = default;
      reference_wrapper&
      operator=(const reference_wrapper&) = default;
      operator _Tp&() const noexcept
      { return this->get(); }
      _Tp&
      get() const noexcept
      { return *_M_data; }
      template<typename... _Args>
 typename result_of<_Tp&(_Args&&...)>::type
 operator()(_Args&&... __args) const
 {
   return std::__invoke(get(), std::forward<_Args>(__args)...);
 }
    };
  template<typename _Tp>
    inline reference_wrapper<_Tp>
    ref(_Tp& __t) noexcept
    { return reference_wrapper<_Tp>(__t); }
  template<typename _Tp>
    inline reference_wrapper<const _Tp>
    cref(const _Tp& __t) noexcept
    { return reference_wrapper<const _Tp>(__t); }
  template<typename _Tp>
    void ref(const _Tp&&) = delete;
  template<typename _Tp>
    void cref(const _Tp&&) = delete;
  template<typename _Tp>
    inline reference_wrapper<_Tp>
    ref(reference_wrapper<_Tp> __t) noexcept
    { return __t; }
  template<typename _Tp>
    inline reference_wrapper<const _Tp>
    cref(reference_wrapper<_Tp> __t) noexcept
    { return { __t.get() }; }

}
       
namespace __gnu_cxx
{
  template<typename _Tp>
    struct __aligned_membuf
    {
      struct _Tp2 { _Tp _M_t; };
      alignas(__alignof__(_Tp2::_M_t)) unsigned char _M_storage[sizeof(_Tp)];
      __aligned_membuf() = default;
      __aligned_membuf(std::nullptr_t) { }
      void*
      _M_addr() noexcept
      { return static_cast<void*>(&_M_storage); }
      const void*
      _M_addr() const noexcept
      { return static_cast<const void*>(&_M_storage); }
      _Tp*
      _M_ptr() noexcept
      { return static_cast<_Tp*>(_M_addr()); }
      const _Tp*
      _M_ptr() const noexcept
      { return static_cast<const _Tp*>(_M_addr()); }
    };
  template<typename _Tp>
    struct __aligned_buffer
    : std::aligned_storage<sizeof(_Tp), std::alignment_of<_Tp>::value>
    {
      typename
 std::aligned_storage<sizeof(_Tp), std::alignment_of<_Tp>::value>::type
 _M_storage;
      __aligned_buffer() = default;
      __aligned_buffer(std::nullptr_t) { }
      void*
      _M_addr() noexcept
      {
        return static_cast<void*>(&_M_storage);
      }
      const void*
      _M_addr() const noexcept
      {
        return static_cast<const void*>(&_M_storage);
      }
      _Tp*
      _M_ptr() noexcept
      { return static_cast<_Tp*>(_M_addr()); }
      const _Tp*
      _M_ptr() const noexcept
      { return static_cast<const _Tp*>(_M_addr()); }
    };
}
namespace std
{

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
  template<typename> class auto_ptr;
#pragma GCC diagnostic pop
  class bad_weak_ptr : public std::exception
  {
  public:
    virtual char const* what() const noexcept;
    virtual ~bad_weak_ptr() noexcept;
  };
  inline void
  __throw_bad_weak_ptr()
  { (throw (bad_weak_ptr())); }
  using __gnu_cxx::_Lock_policy;
  using __gnu_cxx::__default_lock_policy;
  using __gnu_cxx::_S_single;
  using __gnu_cxx::_S_mutex;
  using __gnu_cxx::_S_atomic;
  template<_Lock_policy _Lp>
    class _Mutex_base
    {
    protected:
      enum { _S_need_barriers = 0 };
    };
  template<>
    class _Mutex_base<_S_mutex>
    : public __gnu_cxx::__mutex
    {
    protected:
      enum { _S_need_barriers = 1 };
    };
  template<_Lock_policy _Lp = __default_lock_policy>
    class _Sp_counted_base
    : public _Mutex_base<_Lp>
    {
    public:
      _Sp_counted_base() noexcept
      : _M_use_count(1), _M_weak_count(1) { }
      virtual
      ~_Sp_counted_base() noexcept
      { }
      virtual void
      _M_dispose() noexcept = 0;
      virtual void
      _M_destroy() noexcept
      { delete this; }
      virtual void*
      _M_get_deleter(const std::type_info&) noexcept = 0;
      void
      _M_add_ref_copy()
      { __gnu_cxx::__atomic_add_dispatch(&_M_use_count, 1); }
      void
      _M_add_ref_lock();
      bool
      _M_add_ref_lock_nothrow();
      void
      _M_release() noexcept
      {
        ;
 if (__gnu_cxx::__exchange_and_add_dispatch(&_M_use_count, -1) == 1)
   {
            ;
     _M_dispose();
     if (_Mutex_base<_Lp>::_S_need_barriers)
       {
  __atomic_thread_fence (4);
       }
            ;
     if (__gnu_cxx::__exchange_and_add_dispatch(&_M_weak_count,
             -1) == 1)
              {
                ;
         _M_destroy();
              }
   }
      }
      void
      _M_weak_add_ref() noexcept
      { __gnu_cxx::__atomic_add_dispatch(&_M_weak_count, 1); }
      void
      _M_weak_release() noexcept
      {
        ;
 if (__gnu_cxx::__exchange_and_add_dispatch(&_M_weak_count, -1) == 1)
   {
            ;
     if (_Mutex_base<_Lp>::_S_need_barriers)
       {
  __atomic_thread_fence (4);
       }
     _M_destroy();
   }
      }
      long
      _M_get_use_count() const noexcept
      {
        return __atomic_load_n(&_M_use_count, 0);
      }
    private:
      _Sp_counted_base(_Sp_counted_base const&) = delete;
      _Sp_counted_base& operator=(_Sp_counted_base const&) = delete;
      _Atomic_word _M_use_count;
      _Atomic_word _M_weak_count;
    };
  template<>
    inline void
    _Sp_counted_base<_S_single>::
    _M_add_ref_lock()
    {
      if (_M_use_count == 0)
 __throw_bad_weak_ptr();
      ++_M_use_count;
    }
  template<>
    inline void
    _Sp_counted_base<_S_mutex>::
    _M_add_ref_lock()
    {
      __gnu_cxx::__scoped_lock sentry(*this);
      if (__gnu_cxx::__exchange_and_add_dispatch(&_M_use_count, 1) == 0)
 {
   _M_use_count = 0;
   __throw_bad_weak_ptr();
 }
    }
  template<>
    inline void
    _Sp_counted_base<_S_atomic>::
    _M_add_ref_lock()
    {
      _Atomic_word __count = _M_get_use_count();
      do
 {
   if (__count == 0)
     __throw_bad_weak_ptr();
 }
      while (!__atomic_compare_exchange_n(&_M_use_count, &__count, __count + 1,
       true, 4,
       0));
    }
  template<>
    inline bool
    _Sp_counted_base<_S_single>::
    _M_add_ref_lock_nothrow()
    {
      if (_M_use_count == 0)
 return false;
      ++_M_use_count;
      return true;
    }
  template<>
    inline bool
    _Sp_counted_base<_S_mutex>::
    _M_add_ref_lock_nothrow()
    {
      __gnu_cxx::__scoped_lock sentry(*this);
      if (__gnu_cxx::__exchange_and_add_dispatch(&_M_use_count, 1) == 0)
 {
   _M_use_count = 0;
   return false;
 }
      return true;
    }
  template<>
    inline bool
    _Sp_counted_base<_S_atomic>::
    _M_add_ref_lock_nothrow()
    {
      _Atomic_word __count = _M_get_use_count();
      do
 {
   if (__count == 0)
     return false;
 }
      while (!__atomic_compare_exchange_n(&_M_use_count, &__count, __count + 1,
       true, 4,
       0));
      return true;
    }
  template<>
    inline void
    _Sp_counted_base<_S_single>::_M_add_ref_copy()
    { ++_M_use_count; }
  template<>
    inline void
    _Sp_counted_base<_S_single>::_M_release() noexcept
    {
      if (--_M_use_count == 0)
        {
          _M_dispose();
          if (--_M_weak_count == 0)
            _M_destroy();
        }
    }
  template<>
    inline void
    _Sp_counted_base<_S_single>::_M_weak_add_ref() noexcept
    { ++_M_weak_count; }
  template<>
    inline void
    _Sp_counted_base<_S_single>::_M_weak_release() noexcept
    {
      if (--_M_weak_count == 0)
        _M_destroy();
    }
  template<>
    inline long
    _Sp_counted_base<_S_single>::_M_get_use_count() const noexcept
    { return _M_use_count; }
  template<typename _Tp, _Lock_policy _Lp = __default_lock_policy>
    class __shared_ptr;
  template<typename _Tp, _Lock_policy _Lp = __default_lock_policy>
    class __weak_ptr;
  template<typename _Tp, _Lock_policy _Lp = __default_lock_policy>
    class __enable_shared_from_this;
  template<typename _Tp>
    class shared_ptr;
  template<typename _Tp>
    class weak_ptr;
  template<typename _Tp>
    struct owner_less;
  template<typename _Tp>
    class enable_shared_from_this;
  template<_Lock_policy _Lp = __default_lock_policy>
    class __weak_count;
  template<_Lock_policy _Lp = __default_lock_policy>
    class __shared_count;
  template<typename _Ptr, _Lock_policy _Lp>
    class _Sp_counted_ptr final : public _Sp_counted_base<_Lp>
    {
    public:
      explicit
      _Sp_counted_ptr(_Ptr __p) noexcept
      : _M_ptr(__p) { }
      virtual void
      _M_dispose() noexcept
      { delete _M_ptr; }
      virtual void
      _M_destroy() noexcept
      { delete this; }
      virtual void*
      _M_get_deleter(const std::type_info&) noexcept
      { return nullptr; }
      _Sp_counted_ptr(const _Sp_counted_ptr&) = delete;
      _Sp_counted_ptr& operator=(const _Sp_counted_ptr&) = delete;
    private:
      _Ptr _M_ptr;
    };
  template<>
    inline void
    _Sp_counted_ptr<nullptr_t, _S_single>::_M_dispose() noexcept { }
  template<>
    inline void
    _Sp_counted_ptr<nullptr_t, _S_mutex>::_M_dispose() noexcept { }
  template<>
    inline void
    _Sp_counted_ptr<nullptr_t, _S_atomic>::_M_dispose() noexcept { }
  template<int _Nm, typename _Tp,
    bool __use_ebo = !__is_final(_Tp) && __is_empty(_Tp)>
    struct _Sp_ebo_helper;
  template<int _Nm, typename _Tp>
    struct _Sp_ebo_helper<_Nm, _Tp, true> : private _Tp
    {
      explicit _Sp_ebo_helper(const _Tp& __tp) : _Tp(__tp) { }
      explicit _Sp_ebo_helper(_Tp&& __tp) : _Tp(std::move(__tp)) { }
      static _Tp&
      _S_get(_Sp_ebo_helper& __eboh) { return static_cast<_Tp&>(__eboh); }
    };
  template<int _Nm, typename _Tp>
    struct _Sp_ebo_helper<_Nm, _Tp, false>
    {
      explicit _Sp_ebo_helper(const _Tp& __tp) : _M_tp(__tp) { }
      explicit _Sp_ebo_helper(_Tp&& __tp) : _M_tp(std::move(__tp)) { }
      static _Tp&
      _S_get(_Sp_ebo_helper& __eboh)
      { return __eboh._M_tp; }
    private:
      _Tp _M_tp;
    };
  template<typename _Ptr, typename _Deleter, typename _Alloc, _Lock_policy _Lp>
    class _Sp_counted_deleter final : public _Sp_counted_base<_Lp>
    {
      class _Impl : _Sp_ebo_helper<0, _Deleter>, _Sp_ebo_helper<1, _Alloc>
      {
 typedef _Sp_ebo_helper<0, _Deleter> _Del_base;
 typedef _Sp_ebo_helper<1, _Alloc> _Alloc_base;
      public:
 _Impl(_Ptr __p, _Deleter __d, const _Alloc& __a) noexcept
 : _M_ptr(__p), _Del_base(std::move(__d)), _Alloc_base(__a)
 { }
 _Deleter& _M_del() noexcept { return _Del_base::_S_get(*this); }
 _Alloc& _M_alloc() noexcept { return _Alloc_base::_S_get(*this); }
 _Ptr _M_ptr;
      };
    public:
      using __allocator_type = __alloc_rebind<_Alloc, _Sp_counted_deleter>;
      _Sp_counted_deleter(_Ptr __p, _Deleter __d) noexcept
      : _M_impl(__p, std::move(__d), _Alloc()) { }
      _Sp_counted_deleter(_Ptr __p, _Deleter __d, const _Alloc& __a) noexcept
      : _M_impl(__p, std::move(__d), __a) { }
      ~_Sp_counted_deleter() noexcept { }
      virtual void
      _M_dispose() noexcept
      { _M_impl._M_del()(_M_impl._M_ptr); }
      virtual void
      _M_destroy() noexcept
      {
 __allocator_type __a(_M_impl._M_alloc());
 __allocated_ptr<__allocator_type> __guard_ptr{ __a, this };
 this->~_Sp_counted_deleter();
      }
      virtual void*
      _M_get_deleter(const std::type_info& __ti) noexcept
      {
        return __ti == typeid(_Deleter)
   ? std::__addressof(_M_impl._M_del())
   : nullptr;
      }
    private:
      _Impl _M_impl;
    };
  struct _Sp_make_shared_tag
  {
  };
  template<typename _Tp, typename _Alloc, _Lock_policy _Lp>
    class _Sp_counted_ptr_inplace final : public _Sp_counted_base<_Lp>
    {
      class _Impl : _Sp_ebo_helper<0, _Alloc>
      {
 typedef _Sp_ebo_helper<0, _Alloc> _A_base;
      public:
 explicit _Impl(_Alloc __a) noexcept : _A_base(__a) { }
 _Alloc& _M_alloc() noexcept { return _A_base::_S_get(*this); }
 __gnu_cxx::__aligned_buffer<_Tp> _M_storage;
      };
    public:
      using __allocator_type = __alloc_rebind<_Alloc, _Sp_counted_ptr_inplace>;
      template<typename... _Args>
 _Sp_counted_ptr_inplace(_Alloc __a, _Args&&... __args)
 : _M_impl(__a)
 {
   allocator_traits<_Alloc>::construct(__a, _M_ptr(),
       std::forward<_Args>(__args)...);
 }
      ~_Sp_counted_ptr_inplace() noexcept { }
      virtual void
      _M_dispose() noexcept
      {
 allocator_traits<_Alloc>::destroy(_M_impl._M_alloc(), _M_ptr());
      }
      virtual void
      _M_destroy() noexcept
      {
 __allocator_type __a(_M_impl._M_alloc());
 __allocated_ptr<__allocator_type> __guard_ptr{ __a, this };
 this->~_Sp_counted_ptr_inplace();
      }
      virtual void*
      _M_get_deleter(const std::type_info& __ti) noexcept
      {
 if (__ti == typeid(_Sp_make_shared_tag))
   return const_cast<typename remove_cv<_Tp>::type*>(_M_ptr());
 return nullptr;
      }
    private:
      _Tp* _M_ptr() noexcept { return _M_impl._M_storage._M_ptr(); }
      _Impl _M_impl;
    };
  struct __sp_array_delete
  {
    template<typename _Yp>
      void operator()(_Yp* __p) const { delete[] __p; }
  };
  template<_Lock_policy _Lp>
    class __shared_count
    {
    public:
      constexpr __shared_count() noexcept : _M_pi(0)
      { }
      template<typename _Ptr>
        explicit
 __shared_count(_Ptr __p) : _M_pi(0)
 {
   try
     {
       _M_pi = new _Sp_counted_ptr<_Ptr, _Lp>(__p);
     }
   catch(...)
     {
       delete __p;
       throw;
     }
 }
      template<typename _Ptr>
 __shared_count(_Ptr __p, false_type)
 : __shared_count(__p)
 { }
      template<typename _Ptr>
 __shared_count(_Ptr __p, true_type)
 : __shared_count(__p, __sp_array_delete{}, allocator<void>())
 { }
      template<typename _Ptr, typename _Deleter>
 __shared_count(_Ptr __p, _Deleter __d)
 : __shared_count(__p, std::move(__d), allocator<void>())
 { }
      template<typename _Ptr, typename _Deleter, typename _Alloc>
 __shared_count(_Ptr __p, _Deleter __d, _Alloc __a) : _M_pi(0)
 {
   typedef _Sp_counted_deleter<_Ptr, _Deleter, _Alloc, _Lp> _Sp_cd_type;
   try
     {
       typename _Sp_cd_type::__allocator_type __a2(__a);
       auto __guard = std::__allocate_guarded(__a2);
       _Sp_cd_type* __mem = __guard.get();
       ::new (__mem) _Sp_cd_type(__p, std::move(__d), std::move(__a));
       _M_pi = __mem;
       __guard = nullptr;
     }
   catch(...)
     {
       __d(__p);
       throw;
     }
 }
      template<typename _Tp, typename _Alloc, typename... _Args>
 __shared_count(_Sp_make_shared_tag, _Tp*, const _Alloc& __a,
         _Args&&... __args)
 : _M_pi(0)
 {
   typedef _Sp_counted_ptr_inplace<_Tp, _Alloc, _Lp> _Sp_cp_type;
   typename _Sp_cp_type::__allocator_type __a2(__a);
   auto __guard = std::__allocate_guarded(__a2);
   _Sp_cp_type* __mem = __guard.get();
   ::new (__mem) _Sp_cp_type(std::move(__a),
        std::forward<_Args>(__args)...);
   _M_pi = __mem;
   __guard = nullptr;
 }
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
      template<typename _Tp>
        explicit
 __shared_count(std::auto_ptr<_Tp>&& __r);
#pragma GCC diagnostic pop
      template<typename _Tp, typename _Del>
        explicit
 __shared_count(std::unique_ptr<_Tp, _Del>&& __r) : _M_pi(0)
 {
   if (__r.get() == nullptr)
     return;
   using _Ptr = typename unique_ptr<_Tp, _Del>::pointer;
   using _Del2 = typename conditional<is_reference<_Del>::value,
       reference_wrapper<typename remove_reference<_Del>::type>,
       _Del>::type;
   using _Sp_cd_type
     = _Sp_counted_deleter<_Ptr, _Del2, allocator<void>, _Lp>;
   using _Alloc = allocator<_Sp_cd_type>;
   using _Alloc_traits = allocator_traits<_Alloc>;
   _Alloc __a;
   _Sp_cd_type* __mem = _Alloc_traits::allocate(__a, 1);
   _Alloc_traits::construct(__a, __mem, __r.release(),
       __r.get_deleter());
   _M_pi = __mem;
 }
      explicit __shared_count(const __weak_count<_Lp>& __r);
      explicit __shared_count(const __weak_count<_Lp>& __r, std::nothrow_t);
      ~__shared_count() noexcept
      {
 if (_M_pi != nullptr)
   _M_pi->_M_release();
      }
      __shared_count(const __shared_count& __r) noexcept
      : _M_pi(__r._M_pi)
      {
 if (_M_pi != 0)
   _M_pi->_M_add_ref_copy();
      }
      __shared_count&
      operator=(const __shared_count& __r) noexcept
      {
 _Sp_counted_base<_Lp>* __tmp = __r._M_pi;
 if (__tmp != _M_pi)
   {
     if (__tmp != 0)
       __tmp->_M_add_ref_copy();
     if (_M_pi != 0)
       _M_pi->_M_release();
     _M_pi = __tmp;
   }
 return *this;
      }
      void
      _M_swap(__shared_count& __r) noexcept
      {
 _Sp_counted_base<_Lp>* __tmp = __r._M_pi;
 __r._M_pi = _M_pi;
 _M_pi = __tmp;
      }
      long
      _M_get_use_count() const noexcept
      { return _M_pi != 0 ? _M_pi->_M_get_use_count() : 0; }
      bool
      _M_unique() const noexcept
      { return this->_M_get_use_count() == 1; }
      void*
      _M_get_deleter(const std::type_info& __ti) const noexcept
      { return _M_pi ? _M_pi->_M_get_deleter(__ti) : nullptr; }
      bool
      _M_less(const __shared_count& __rhs) const noexcept
      { return std::less<_Sp_counted_base<_Lp>*>()(this->_M_pi, __rhs._M_pi); }
      bool
      _M_less(const __weak_count<_Lp>& __rhs) const noexcept
      { return std::less<_Sp_counted_base<_Lp>*>()(this->_M_pi, __rhs._M_pi); }
      friend inline bool
      operator==(const __shared_count& __a, const __shared_count& __b) noexcept
      { return __a._M_pi == __b._M_pi; }
    private:
      friend class __weak_count<_Lp>;
      _Sp_counted_base<_Lp>* _M_pi;
    };
  template<_Lock_policy _Lp>
    class __weak_count
    {
    public:
      constexpr __weak_count() noexcept : _M_pi(nullptr)
      { }
      __weak_count(const __shared_count<_Lp>& __r) noexcept
      : _M_pi(__r._M_pi)
      {
 if (_M_pi != nullptr)
   _M_pi->_M_weak_add_ref();
      }
      __weak_count(const __weak_count& __r) noexcept
      : _M_pi(__r._M_pi)
      {
 if (_M_pi != nullptr)
   _M_pi->_M_weak_add_ref();
      }
      __weak_count(__weak_count&& __r) noexcept
      : _M_pi(__r._M_pi)
      { __r._M_pi = nullptr; }
      ~__weak_count() noexcept
      {
 if (_M_pi != nullptr)
   _M_pi->_M_weak_release();
      }
      __weak_count&
      operator=(const __shared_count<_Lp>& __r) noexcept
      {
 _Sp_counted_base<_Lp>* __tmp = __r._M_pi;
 if (__tmp != nullptr)
   __tmp->_M_weak_add_ref();
 if (_M_pi != nullptr)
   _M_pi->_M_weak_release();
 _M_pi = __tmp;
 return *this;
      }
      __weak_count&
      operator=(const __weak_count& __r) noexcept
      {
 _Sp_counted_base<_Lp>* __tmp = __r._M_pi;
 if (__tmp != nullptr)
   __tmp->_M_weak_add_ref();
 if (_M_pi != nullptr)
   _M_pi->_M_weak_release();
 _M_pi = __tmp;
 return *this;
      }
      __weak_count&
      operator=(__weak_count&& __r) noexcept
      {
 if (_M_pi != nullptr)
   _M_pi->_M_weak_release();
 _M_pi = __r._M_pi;
        __r._M_pi = nullptr;
 return *this;
      }
      void
      _M_swap(__weak_count& __r) noexcept
      {
 _Sp_counted_base<_Lp>* __tmp = __r._M_pi;
 __r._M_pi = _M_pi;
 _M_pi = __tmp;
      }
      long
      _M_get_use_count() const noexcept
      { return _M_pi != nullptr ? _M_pi->_M_get_use_count() : 0; }
      bool
      _M_less(const __weak_count& __rhs) const noexcept
      { return std::less<_Sp_counted_base<_Lp>*>()(this->_M_pi, __rhs._M_pi); }
      bool
      _M_less(const __shared_count<_Lp>& __rhs) const noexcept
      { return std::less<_Sp_counted_base<_Lp>*>()(this->_M_pi, __rhs._M_pi); }
      friend inline bool
      operator==(const __weak_count& __a, const __weak_count& __b) noexcept
      { return __a._M_pi == __b._M_pi; }
    private:
      friend class __shared_count<_Lp>;
      _Sp_counted_base<_Lp>* _M_pi;
    };
  template<_Lock_policy _Lp>
    inline
    __shared_count<_Lp>::__shared_count(const __weak_count<_Lp>& __r)
    : _M_pi(__r._M_pi)
    {
      if (_M_pi != nullptr)
 _M_pi->_M_add_ref_lock();
      else
 __throw_bad_weak_ptr();
    }
  template<_Lock_policy _Lp>
    inline
    __shared_count<_Lp>::
    __shared_count(const __weak_count<_Lp>& __r, std::nothrow_t)
    : _M_pi(__r._M_pi)
    {
      if (_M_pi != nullptr)
 if (!_M_pi->_M_add_ref_lock_nothrow())
   _M_pi = nullptr;
    }
  template<typename _Yp_ptr, typename _Tp_ptr>
    struct __sp_compatible_with
    : false_type
    { };
  template<typename _Yp, typename _Tp>
    struct __sp_compatible_with<_Yp*, _Tp*>
    : is_convertible<_Yp*, _Tp*>::type
    { };
  template<typename _Up, size_t _Nm>
    struct __sp_compatible_with<_Up(*)[_Nm], _Up(*)[]>
    : true_type
    { };
  template<typename _Up, size_t _Nm>
    struct __sp_compatible_with<_Up(*)[_Nm], const _Up(*)[]>
    : true_type
    { };
  template<typename _Up, size_t _Nm>
    struct __sp_compatible_with<_Up(*)[_Nm], volatile _Up(*)[]>
    : true_type
    { };
  template<typename _Up, size_t _Nm>
    struct __sp_compatible_with<_Up(*)[_Nm], const volatile _Up(*)[]>
    : true_type
    { };
  template<typename _Up, size_t _Nm, typename _Yp, typename = void>
    struct __sp_is_constructible_arrN
    : false_type
    { };
  template<typename _Up, size_t _Nm, typename _Yp>
    struct __sp_is_constructible_arrN<_Up, _Nm, _Yp, __void_t<_Yp[_Nm]>>
    : is_convertible<_Yp(*)[_Nm], _Up(*)[_Nm]>::type
    { };
  template<typename _Up, typename _Yp, typename = void>
    struct __sp_is_constructible_arr
    : false_type
    { };
  template<typename _Up, typename _Yp>
    struct __sp_is_constructible_arr<_Up, _Yp, __void_t<_Yp[]>>
    : is_convertible<_Yp(*)[], _Up(*)[]>::type
    { };
  template<typename _Tp, typename _Yp>
    struct __sp_is_constructible;
  template<typename _Up, size_t _Nm, typename _Yp>
    struct __sp_is_constructible<_Up[_Nm], _Yp>
    : __sp_is_constructible_arrN<_Up, _Nm, _Yp>::type
    { };
  template<typename _Up, typename _Yp>
    struct __sp_is_constructible<_Up[], _Yp>
    : __sp_is_constructible_arr<_Up, _Yp>::type
    { };
  template<typename _Tp, typename _Yp>
    struct __sp_is_constructible
    : is_convertible<_Yp*, _Tp*>::type
    { };
  template<typename _Tp, _Lock_policy _Lp,
    bool = is_array<_Tp>::value, bool = is_void<_Tp>::value>
    class __shared_ptr_access
    {
    public:
      using element_type = _Tp;
      element_type&
      operator*() const noexcept
      {
 ;
 return *_M_get();
      }
      element_type*
      operator->() const noexcept
      {
 ;
 return _M_get();
      }
    private:
      element_type*
      _M_get() const noexcept
      { return static_cast<const __shared_ptr<_Tp, _Lp>*>(this)->get(); }
    };
  template<typename _Tp, _Lock_policy _Lp>
    class __shared_ptr_access<_Tp, _Lp, false, true>
    {
    public:
      using element_type = _Tp;
      element_type*
      operator->() const noexcept
      {
 auto __ptr = static_cast<const __shared_ptr<_Tp, _Lp>*>(this)->get();
 ;
 return __ptr;
      }
    };
  template<typename _Tp, _Lock_policy _Lp>
    class __shared_ptr_access<_Tp, _Lp, true, false>
    {
    public:
      using element_type = typename remove_extent<_Tp>::type;
      [[__deprecated__("shared_ptr<T[]>::operator* is absent from C++17")]]
      element_type&
      operator*() const noexcept
      {
 ;
 return *_M_get();
      }
      [[__deprecated__("shared_ptr<T[]>::operator-> is absent from C++17")]]
      element_type*
      operator->() const noexcept
      {
 ;
 return _M_get();
      }
      element_type&
      operator[](ptrdiff_t __i) const
      {
 ;
 ;
 return _M_get()[__i];
      }
    private:
      element_type*
      _M_get() const noexcept
      { return static_cast<const __shared_ptr<_Tp, _Lp>*>(this)->get(); }
    };
  template<typename _Tp, _Lock_policy _Lp>
    class __shared_ptr
    : public __shared_ptr_access<_Tp, _Lp>
    {
    public:
      using element_type = typename remove_extent<_Tp>::type;
    private:
      template<typename _Yp>
 using _SafeConv
   = typename enable_if<__sp_is_constructible<_Tp, _Yp>::value>::type;
      template<typename _Yp, typename _Res = void>
 using _Compatible = typename
   enable_if<__sp_compatible_with<_Yp*, _Tp*>::value, _Res>::type;
      template<typename _Yp>
 using _Assignable = _Compatible<_Yp, __shared_ptr&>;
      template<typename _Yp, typename _Del, typename _Res = void,
        typename _Ptr = typename unique_ptr<_Yp, _Del>::pointer>
 using _UniqCompatible = typename enable_if<__and_<
   __sp_compatible_with<_Yp*, _Tp*>, is_convertible<_Ptr, element_type*>
   >::value, _Res>::type;
      template<typename _Yp, typename _Del>
 using _UniqAssignable = _UniqCompatible<_Yp, _Del, __shared_ptr&>;
    public:
      constexpr __shared_ptr() noexcept
      : _M_ptr(0), _M_refcount()
      { }
      template<typename _Yp, typename = _SafeConv<_Yp>>
 explicit
 __shared_ptr(_Yp* __p)
 : _M_ptr(__p), _M_refcount(__p, typename is_array<_Tp>::type())
 {
   static_assert( !is_void<_Yp>::value, "incomplete type" );
   static_assert( sizeof(_Yp) > 0, "incomplete type" );
   _M_enable_shared_from_this_with(__p);
 }
      template<typename _Yp, typename _Deleter, typename = _SafeConv<_Yp>>
 __shared_ptr(_Yp* __p, _Deleter __d)
 : _M_ptr(__p), _M_refcount(__p, std::move(__d))
 {
   static_assert(__is_invocable<_Deleter&, _Yp*&>::value,
       "deleter expression d(p) is well-formed");
   _M_enable_shared_from_this_with(__p);
 }
      template<typename _Yp, typename _Deleter, typename _Alloc,
        typename = _SafeConv<_Yp>>
 __shared_ptr(_Yp* __p, _Deleter __d, _Alloc __a)
 : _M_ptr(__p), _M_refcount(__p, std::move(__d), std::move(__a))
 {
   static_assert(__is_invocable<_Deleter&, _Yp*&>::value,
       "deleter expression d(p) is well-formed");
   _M_enable_shared_from_this_with(__p);
 }
      template<typename _Deleter>
 __shared_ptr(nullptr_t __p, _Deleter __d)
 : _M_ptr(0), _M_refcount(__p, std::move(__d))
 { }
      template<typename _Deleter, typename _Alloc>
        __shared_ptr(nullptr_t __p, _Deleter __d, _Alloc __a)
 : _M_ptr(0), _M_refcount(__p, std::move(__d), std::move(__a))
 { }
      template<typename _Yp>
 __shared_ptr(const __shared_ptr<_Yp, _Lp>& __r,
       element_type* __p) noexcept
 : _M_ptr(__p), _M_refcount(__r._M_refcount)
 { }
      __shared_ptr(const __shared_ptr&) noexcept = default;
      __shared_ptr& operator=(const __shared_ptr&) noexcept = default;
      ~__shared_ptr() = default;
      template<typename _Yp, typename = _Compatible<_Yp>>
 __shared_ptr(const __shared_ptr<_Yp, _Lp>& __r) noexcept
 : _M_ptr(__r._M_ptr), _M_refcount(__r._M_refcount)
 { }
      __shared_ptr(__shared_ptr&& __r) noexcept
      : _M_ptr(__r._M_ptr), _M_refcount()
      {
 _M_refcount._M_swap(__r._M_refcount);
 __r._M_ptr = 0;
      }
      template<typename _Yp, typename = _Compatible<_Yp>>
 __shared_ptr(__shared_ptr<_Yp, _Lp>&& __r) noexcept
 : _M_ptr(__r._M_ptr), _M_refcount()
 {
   _M_refcount._M_swap(__r._M_refcount);
   __r._M_ptr = 0;
 }
      template<typename _Yp, typename = _Compatible<_Yp>>
 explicit __shared_ptr(const __weak_ptr<_Yp, _Lp>& __r)
 : _M_refcount(__r._M_refcount)
 {
   _M_ptr = __r._M_ptr;
 }
      template<typename _Yp, typename _Del,
        typename = _UniqCompatible<_Yp, _Del>>
 __shared_ptr(unique_ptr<_Yp, _Del>&& __r)
 : _M_ptr(__r.get()), _M_refcount()
 {
   auto __raw = __to_address(__r.get());
   _M_refcount = __shared_count<_Lp>(std::move(__r));
   _M_enable_shared_from_this_with(__raw);
 }
    protected:
      template<typename _Tp1, typename _Del,
        typename enable_if<__and_<
   __not_<is_array<_Tp>>, is_array<_Tp1>,
          is_convertible<typename unique_ptr<_Tp1, _Del>::pointer, _Tp*>
        >::value, bool>::type = true>
 __shared_ptr(unique_ptr<_Tp1, _Del>&& __r, __sp_array_delete)
 : _M_ptr(__r.get()), _M_refcount()
 {
   auto __raw = __to_address(__r.get());
   _M_refcount = __shared_count<_Lp>(std::move(__r));
   _M_enable_shared_from_this_with(__raw);
 }
    public:
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
      template<typename _Yp, typename = _Compatible<_Yp>>
 __shared_ptr(auto_ptr<_Yp>&& __r);
#pragma GCC diagnostic pop
      constexpr __shared_ptr(nullptr_t) noexcept : __shared_ptr() { }
      template<typename _Yp>
 _Assignable<_Yp>
 operator=(const __shared_ptr<_Yp, _Lp>& __r) noexcept
 {
   _M_ptr = __r._M_ptr;
   _M_refcount = __r._M_refcount;
   return *this;
 }
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
      template<typename _Yp>
 _Assignable<_Yp>
 operator=(auto_ptr<_Yp>&& __r)
 {
   __shared_ptr(std::move(__r)).swap(*this);
   return *this;
 }
#pragma GCC diagnostic pop
      __shared_ptr&
      operator=(__shared_ptr&& __r) noexcept
      {
 __shared_ptr(std::move(__r)).swap(*this);
 return *this;
      }
      template<class _Yp>
 _Assignable<_Yp>
 operator=(__shared_ptr<_Yp, _Lp>&& __r) noexcept
 {
   __shared_ptr(std::move(__r)).swap(*this);
   return *this;
 }
      template<typename _Yp, typename _Del>
 _UniqAssignable<_Yp, _Del>
 operator=(unique_ptr<_Yp, _Del>&& __r)
 {
   __shared_ptr(std::move(__r)).swap(*this);
   return *this;
 }
      void
      reset() noexcept
      { __shared_ptr().swap(*this); }
      template<typename _Yp>
 _SafeConv<_Yp>
 reset(_Yp* __p)
 {
   ;
   __shared_ptr(__p).swap(*this);
 }
      template<typename _Yp, typename _Deleter>
 _SafeConv<_Yp>
 reset(_Yp* __p, _Deleter __d)
 { __shared_ptr(__p, std::move(__d)).swap(*this); }
      template<typename _Yp, typename _Deleter, typename _Alloc>
 _SafeConv<_Yp>
 reset(_Yp* __p, _Deleter __d, _Alloc __a)
        { __shared_ptr(__p, std::move(__d), std::move(__a)).swap(*this); }
      element_type*
      get() const noexcept
      { return _M_ptr; }
      explicit operator bool() const
      { return _M_ptr == 0 ? false : true; }
      bool
      unique() const noexcept
      { return _M_refcount._M_unique(); }
      long
      use_count() const noexcept
      { return _M_refcount._M_get_use_count(); }
      void
      swap(__shared_ptr<_Tp, _Lp>& __other) noexcept
      {
 std::swap(_M_ptr, __other._M_ptr);
 _M_refcount._M_swap(__other._M_refcount);
      }
      template<typename _Tp1>
 bool
 owner_before(__shared_ptr<_Tp1, _Lp> const& __rhs) const noexcept
 { return _M_refcount._M_less(__rhs._M_refcount); }
      template<typename _Tp1>
 bool
 owner_before(__weak_ptr<_Tp1, _Lp> const& __rhs) const noexcept
 { return _M_refcount._M_less(__rhs._M_refcount); }
    protected:
      template<typename _Alloc, typename... _Args>
 __shared_ptr(_Sp_make_shared_tag __tag, const _Alloc& __a,
       _Args&&... __args)
 : _M_ptr(), _M_refcount(__tag, (_Tp*)0, __a,
    std::forward<_Args>(__args)...)
 {
   void* __p = _M_refcount._M_get_deleter(typeid(__tag));
   _M_ptr = static_cast<_Tp*>(__p);
   _M_enable_shared_from_this_with(_M_ptr);
 }
      template<typename _Tp1, _Lock_policy _Lp1, typename _Alloc,
        typename... _Args>
 friend __shared_ptr<_Tp1, _Lp1>
 __allocate_shared(const _Alloc& __a, _Args&&... __args);
      __shared_ptr(const __weak_ptr<_Tp, _Lp>& __r, std::nothrow_t)
      : _M_refcount(__r._M_refcount, std::nothrow)
      {
 _M_ptr = _M_refcount._M_get_use_count() ? __r._M_ptr : nullptr;
      }
      friend class __weak_ptr<_Tp, _Lp>;
    private:
      template<typename _Yp>
 using __esft_base_t = decltype(__enable_shared_from_this_base(
       std::declval<const __shared_count<_Lp>&>(),
       std::declval<_Yp*>()));
      template<typename _Yp, typename = void>
 struct __has_esft_base
 : false_type { };
      template<typename _Yp>
 struct __has_esft_base<_Yp, __void_t<__esft_base_t<_Yp>>>
 : __not_<is_array<_Tp>> { };
      template<typename _Yp, typename _Yp2 = typename remove_cv<_Yp>::type>
 typename enable_if<__has_esft_base<_Yp2>::value>::type
 _M_enable_shared_from_this_with(_Yp* __p) noexcept
 {
   if (auto __base = __enable_shared_from_this_base(_M_refcount, __p))
     __base->_M_weak_assign(const_cast<_Yp2*>(__p), _M_refcount);
 }
      template<typename _Yp, typename _Yp2 = typename remove_cv<_Yp>::type>
 typename enable_if<!__has_esft_base<_Yp2>::value>::type
 _M_enable_shared_from_this_with(_Yp*) noexcept
 { }
      void*
      _M_get_deleter(const std::type_info& __ti) const noexcept
      { return _M_refcount._M_get_deleter(__ti); }
      template<typename _Tp1, _Lock_policy _Lp1> friend class __shared_ptr;
      template<typename _Tp1, _Lock_policy _Lp1> friend class __weak_ptr;
      template<typename _Del, typename _Tp1, _Lock_policy _Lp1>
 friend _Del* get_deleter(const __shared_ptr<_Tp1, _Lp1>&) noexcept;
      template<typename _Del, typename _Tp1>
 friend _Del* get_deleter(const shared_ptr<_Tp1>&) noexcept;
      element_type* _M_ptr;
      __shared_count<_Lp> _M_refcount;
    };
  template<typename _Tp1, typename _Tp2, _Lock_policy _Lp>
    inline bool
    operator==(const __shared_ptr<_Tp1, _Lp>& __a,
        const __shared_ptr<_Tp2, _Lp>& __b) noexcept
    { return __a.get() == __b.get(); }
  template<typename _Tp, _Lock_policy _Lp>
    inline bool
    operator==(const __shared_ptr<_Tp, _Lp>& __a, nullptr_t) noexcept
    { return !__a; }
  template<typename _Tp, _Lock_policy _Lp>
    inline bool
    operator==(nullptr_t, const __shared_ptr<_Tp, _Lp>& __a) noexcept
    { return !__a; }
  template<typename _Tp1, typename _Tp2, _Lock_policy _Lp>
    inline bool
    operator!=(const __shared_ptr<_Tp1, _Lp>& __a,
        const __shared_ptr<_Tp2, _Lp>& __b) noexcept
    { return __a.get() != __b.get(); }
  template<typename _Tp, _Lock_policy _Lp>
    inline bool
    operator!=(const __shared_ptr<_Tp, _Lp>& __a, nullptr_t) noexcept
    { return (bool)__a; }
  template<typename _Tp, _Lock_policy _Lp>
    inline bool
    operator!=(nullptr_t, const __shared_ptr<_Tp, _Lp>& __a) noexcept
    { return (bool)__a; }
  template<typename _Tp, typename _Up, _Lock_policy _Lp>
    inline bool
    operator<(const __shared_ptr<_Tp, _Lp>& __a,
       const __shared_ptr<_Up, _Lp>& __b) noexcept
    {
      using _Tp_elt = typename __shared_ptr<_Tp, _Lp>::element_type;
      using _Up_elt = typename __shared_ptr<_Up, _Lp>::element_type;
      using _Vp = typename common_type<_Tp_elt*, _Up_elt*>::type;
      return less<_Vp>()(__a.get(), __b.get());
    }
  template<typename _Tp, _Lock_policy _Lp>
    inline bool
    operator<(const __shared_ptr<_Tp, _Lp>& __a, nullptr_t) noexcept
    {
      using _Tp_elt = typename __shared_ptr<_Tp, _Lp>::element_type;
      return less<_Tp_elt*>()(__a.get(), nullptr);
    }
  template<typename _Tp, _Lock_policy _Lp>
    inline bool
    operator<(nullptr_t, const __shared_ptr<_Tp, _Lp>& __a) noexcept
    {
      using _Tp_elt = typename __shared_ptr<_Tp, _Lp>::element_type;
      return less<_Tp_elt*>()(nullptr, __a.get());
    }
  template<typename _Tp1, typename _Tp2, _Lock_policy _Lp>
    inline bool
    operator<=(const __shared_ptr<_Tp1, _Lp>& __a,
        const __shared_ptr<_Tp2, _Lp>& __b) noexcept
    { return !(__b < __a); }
  template<typename _Tp, _Lock_policy _Lp>
    inline bool
    operator<=(const __shared_ptr<_Tp, _Lp>& __a, nullptr_t) noexcept
    { return !(nullptr < __a); }
  template<typename _Tp, _Lock_policy _Lp>
    inline bool
    operator<=(nullptr_t, const __shared_ptr<_Tp, _Lp>& __a) noexcept
    { return !(__a < nullptr); }
  template<typename _Tp1, typename _Tp2, _Lock_policy _Lp>
    inline bool
    operator>(const __shared_ptr<_Tp1, _Lp>& __a,
       const __shared_ptr<_Tp2, _Lp>& __b) noexcept
    { return (__b < __a); }
  template<typename _Tp, _Lock_policy _Lp>
    inline bool
    operator>(const __shared_ptr<_Tp, _Lp>& __a, nullptr_t) noexcept
    { return nullptr < __a; }
  template<typename _Tp, _Lock_policy _Lp>
    inline bool
    operator>(nullptr_t, const __shared_ptr<_Tp, _Lp>& __a) noexcept
    { return __a < nullptr; }
  template<typename _Tp1, typename _Tp2, _Lock_policy _Lp>
    inline bool
    operator>=(const __shared_ptr<_Tp1, _Lp>& __a,
        const __shared_ptr<_Tp2, _Lp>& __b) noexcept
    { return !(__a < __b); }
  template<typename _Tp, _Lock_policy _Lp>
    inline bool
    operator>=(const __shared_ptr<_Tp, _Lp>& __a, nullptr_t) noexcept
    { return !(__a < nullptr); }
  template<typename _Tp, _Lock_policy _Lp>
    inline bool
    operator>=(nullptr_t, const __shared_ptr<_Tp, _Lp>& __a) noexcept
    { return !(nullptr < __a); }
  template<typename _Sp>
    struct _Sp_less : public binary_function<_Sp, _Sp, bool>
    {
      bool
      operator()(const _Sp& __lhs, const _Sp& __rhs) const noexcept
      {
 typedef typename _Sp::element_type element_type;
 return std::less<element_type*>()(__lhs.get(), __rhs.get());
      }
    };
  template<typename _Tp, _Lock_policy _Lp>
    struct less<__shared_ptr<_Tp, _Lp>>
    : public _Sp_less<__shared_ptr<_Tp, _Lp>>
    { };
  template<typename _Tp, _Lock_policy _Lp>
    inline void
    swap(__shared_ptr<_Tp, _Lp>& __a, __shared_ptr<_Tp, _Lp>& __b) noexcept
    { __a.swap(__b); }
  template<typename _Tp, typename _Tp1, _Lock_policy _Lp>
    inline __shared_ptr<_Tp, _Lp>
    static_pointer_cast(const __shared_ptr<_Tp1, _Lp>& __r) noexcept
    {
      using _Sp = __shared_ptr<_Tp, _Lp>;
      return _Sp(__r, static_cast<typename _Sp::element_type*>(__r.get()));
    }
  template<typename _Tp, typename _Tp1, _Lock_policy _Lp>
    inline __shared_ptr<_Tp, _Lp>
    const_pointer_cast(const __shared_ptr<_Tp1, _Lp>& __r) noexcept
    {
      using _Sp = __shared_ptr<_Tp, _Lp>;
      return _Sp(__r, const_cast<typename _Sp::element_type*>(__r.get()));
    }
  template<typename _Tp, typename _Tp1, _Lock_policy _Lp>
    inline __shared_ptr<_Tp, _Lp>
    dynamic_pointer_cast(const __shared_ptr<_Tp1, _Lp>& __r) noexcept
    {
      using _Sp = __shared_ptr<_Tp, _Lp>;
      if (auto* __p = dynamic_cast<typename _Sp::element_type*>(__r.get()))
 return _Sp(__r, __p);
      return _Sp();
    }
  template<typename _Tp, _Lock_policy _Lp>
    class __weak_ptr
    {
      template<typename _Yp, typename _Res = void>
 using _Compatible = typename
   enable_if<__sp_compatible_with<_Yp*, _Tp*>::value, _Res>::type;
      template<typename _Yp>
 using _Assignable = _Compatible<_Yp, __weak_ptr&>;
    public:
      using element_type = typename remove_extent<_Tp>::type;
      constexpr __weak_ptr() noexcept
      : _M_ptr(nullptr), _M_refcount()
      { }
      __weak_ptr(const __weak_ptr&) noexcept = default;
      ~__weak_ptr() = default;
      template<typename _Yp, typename = _Compatible<_Yp>>
 __weak_ptr(const __weak_ptr<_Yp, _Lp>& __r) noexcept
 : _M_refcount(__r._M_refcount)
        { _M_ptr = __r.lock().get(); }
      template<typename _Yp, typename = _Compatible<_Yp>>
 __weak_ptr(const __shared_ptr<_Yp, _Lp>& __r) noexcept
 : _M_ptr(__r._M_ptr), _M_refcount(__r._M_refcount)
 { }
      __weak_ptr(__weak_ptr&& __r) noexcept
      : _M_ptr(__r._M_ptr), _M_refcount(std::move(__r._M_refcount))
      { __r._M_ptr = nullptr; }
      template<typename _Yp, typename = _Compatible<_Yp>>
 __weak_ptr(__weak_ptr<_Yp, _Lp>&& __r) noexcept
 : _M_ptr(__r.lock().get()), _M_refcount(std::move(__r._M_refcount))
        { __r._M_ptr = nullptr; }
      __weak_ptr&
      operator=(const __weak_ptr& __r) noexcept = default;
      template<typename _Yp>
 _Assignable<_Yp>
 operator=(const __weak_ptr<_Yp, _Lp>& __r) noexcept
 {
   _M_ptr = __r.lock().get();
   _M_refcount = __r._M_refcount;
   return *this;
 }
      template<typename _Yp>
 _Assignable<_Yp>
 operator=(const __shared_ptr<_Yp, _Lp>& __r) noexcept
 {
   _M_ptr = __r._M_ptr;
   _M_refcount = __r._M_refcount;
   return *this;
 }
      __weak_ptr&
      operator=(__weak_ptr&& __r) noexcept
      {
 _M_ptr = __r._M_ptr;
 _M_refcount = std::move(__r._M_refcount);
 __r._M_ptr = nullptr;
 return *this;
      }
      template<typename _Yp>
 _Assignable<_Yp>
 operator=(__weak_ptr<_Yp, _Lp>&& __r) noexcept
 {
   _M_ptr = __r.lock().get();
   _M_refcount = std::move(__r._M_refcount);
   __r._M_ptr = nullptr;
   return *this;
 }
      __shared_ptr<_Tp, _Lp>
      lock() const noexcept
      { return __shared_ptr<element_type, _Lp>(*this, std::nothrow); }
      long
      use_count() const noexcept
      { return _M_refcount._M_get_use_count(); }
      bool
      expired() const noexcept
      { return _M_refcount._M_get_use_count() == 0; }
      template<typename _Tp1>
 bool
 owner_before(const __shared_ptr<_Tp1, _Lp>& __rhs) const noexcept
 { return _M_refcount._M_less(__rhs._M_refcount); }
      template<typename _Tp1>
 bool
 owner_before(const __weak_ptr<_Tp1, _Lp>& __rhs) const noexcept
 { return _M_refcount._M_less(__rhs._M_refcount); }
      void
      reset() noexcept
      { __weak_ptr().swap(*this); }
      void
      swap(__weak_ptr& __s) noexcept
      {
 std::swap(_M_ptr, __s._M_ptr);
 _M_refcount._M_swap(__s._M_refcount);
      }
    private:
      void
      _M_assign(_Tp* __ptr, const __shared_count<_Lp>& __refcount) noexcept
      {
 if (use_count() == 0)
   {
     _M_ptr = __ptr;
     _M_refcount = __refcount;
   }
      }
      template<typename _Tp1, _Lock_policy _Lp1> friend class __shared_ptr;
      template<typename _Tp1, _Lock_policy _Lp1> friend class __weak_ptr;
      friend class __enable_shared_from_this<_Tp, _Lp>;
      friend class enable_shared_from_this<_Tp>;
      element_type* _M_ptr;
      __weak_count<_Lp> _M_refcount;
    };
  template<typename _Tp, _Lock_policy _Lp>
    inline void
    swap(__weak_ptr<_Tp, _Lp>& __a, __weak_ptr<_Tp, _Lp>& __b) noexcept
    { __a.swap(__b); }
  template<typename _Tp, typename _Tp1>
    struct _Sp_owner_less : public binary_function<_Tp, _Tp, bool>
    {
      bool
      operator()(const _Tp& __lhs, const _Tp& __rhs) const noexcept
      { return __lhs.owner_before(__rhs); }
      bool
      operator()(const _Tp& __lhs, const _Tp1& __rhs) const noexcept
      { return __lhs.owner_before(__rhs); }
      bool
      operator()(const _Tp1& __lhs, const _Tp& __rhs) const noexcept
      { return __lhs.owner_before(__rhs); }
    };
  template<>
    struct _Sp_owner_less<void, void>
    {
      template<typename _Tp, typename _Up>
 auto
 operator()(const _Tp& __lhs, const _Up& __rhs) const noexcept
 -> decltype(__lhs.owner_before(__rhs))
 { return __lhs.owner_before(__rhs); }
      using is_transparent = void;
    };
  template<typename _Tp, _Lock_policy _Lp>
    struct owner_less<__shared_ptr<_Tp, _Lp>>
    : public _Sp_owner_less<__shared_ptr<_Tp, _Lp>, __weak_ptr<_Tp, _Lp>>
    { };
  template<typename _Tp, _Lock_policy _Lp>
    struct owner_less<__weak_ptr<_Tp, _Lp>>
    : public _Sp_owner_less<__weak_ptr<_Tp, _Lp>, __shared_ptr<_Tp, _Lp>>
    { };
  template<typename _Tp, _Lock_policy _Lp>
    class __enable_shared_from_this
    {
    protected:
      constexpr __enable_shared_from_this() noexcept { }
      __enable_shared_from_this(const __enable_shared_from_this&) noexcept { }
      __enable_shared_from_this&
      operator=(const __enable_shared_from_this&) noexcept
      { return *this; }
      ~__enable_shared_from_this() { }
    public:
      __shared_ptr<_Tp, _Lp>
      shared_from_this()
      { return __shared_ptr<_Tp, _Lp>(this->_M_weak_this); }
      __shared_ptr<const _Tp, _Lp>
      shared_from_this() const
      { return __shared_ptr<const _Tp, _Lp>(this->_M_weak_this); }
      __weak_ptr<_Tp, _Lp>
      weak_from_this() noexcept
      { return this->_M_weak_this; }
      __weak_ptr<const _Tp, _Lp>
      weak_from_this() const noexcept
      { return this->_M_weak_this; }
    private:
      template<typename _Tp1>
 void
 _M_weak_assign(_Tp1* __p, const __shared_count<_Lp>& __n) const noexcept
 { _M_weak_this._M_assign(__p, __n); }
      friend const __enable_shared_from_this*
      __enable_shared_from_this_base(const __shared_count<_Lp>&,
         const __enable_shared_from_this* __p)
      { return __p; }
      template<typename, _Lock_policy>
 friend class __shared_ptr;
      mutable __weak_ptr<_Tp, _Lp> _M_weak_this;
    };
  template<typename _Tp, _Lock_policy _Lp, typename _Alloc, typename... _Args>
    inline __shared_ptr<_Tp, _Lp>
    __allocate_shared(const _Alloc& __a, _Args&&... __args)
    {
      return __shared_ptr<_Tp, _Lp>(_Sp_make_shared_tag(), __a,
        std::forward<_Args>(__args)...);
    }
  template<typename _Tp, _Lock_policy _Lp, typename... _Args>
    inline __shared_ptr<_Tp, _Lp>
    __make_shared(_Args&&... __args)
    {
      typedef typename std::remove_const<_Tp>::type _Tp_nc;
      return std::__allocate_shared<_Tp, _Lp>(std::allocator<_Tp_nc>(),
           std::forward<_Args>(__args)...);
    }
  template<typename _Tp, _Lock_policy _Lp>
    struct hash<__shared_ptr<_Tp, _Lp>>
    : public __hash_base<size_t, __shared_ptr<_Tp, _Lp>>
    {
      size_t
      operator()(const __shared_ptr<_Tp, _Lp>& __s) const noexcept
      {
 return hash<typename __shared_ptr<_Tp, _Lp>::element_type*>()(
     __s.get());
      }
    };

}
namespace std
{

  template<typename _Ch, typename _Tr, typename _Tp, _Lock_policy _Lp>
    inline std::basic_ostream<_Ch, _Tr>&
    operator<<(std::basic_ostream<_Ch, _Tr>& __os,
        const __shared_ptr<_Tp, _Lp>& __p)
    {
      __os << __p.get();
      return __os;
    }
  template<typename _Del, typename _Tp, _Lock_policy _Lp>
    inline _Del*
    get_deleter(const __shared_ptr<_Tp, _Lp>& __p) noexcept
    {
      return static_cast<_Del*>(__p._M_get_deleter(typeid(_Del)));
    }
  template<typename _Del, typename _Tp>
    inline _Del*
    get_deleter(const shared_ptr<_Tp>& __p) noexcept
    {
      return static_cast<_Del*>(__p._M_get_deleter(typeid(_Del)));
    }
  template<typename _Tp>
    class shared_ptr : public __shared_ptr<_Tp>
    {
      template<typename... _Args>
 using _Constructible = typename enable_if<
   is_constructible<__shared_ptr<_Tp>, _Args...>::value
 >::type;
      template<typename _Arg>
 using _Assignable = typename enable_if<
   is_assignable<__shared_ptr<_Tp>&, _Arg>::value, shared_ptr&
 >::type;
    public:
      using element_type = typename __shared_ptr<_Tp>::element_type;
      constexpr shared_ptr() noexcept : __shared_ptr<_Tp>() { }
      shared_ptr(const shared_ptr&) noexcept = default;
      template<typename _Yp, typename = _Constructible<_Yp*>>
 explicit
 shared_ptr(_Yp* __p) : __shared_ptr<_Tp>(__p) { }
      template<typename _Yp, typename _Deleter,
        typename = _Constructible<_Yp*, _Deleter>>
 shared_ptr(_Yp* __p, _Deleter __d)
        : __shared_ptr<_Tp>(__p, std::move(__d)) { }
      template<typename _Deleter>
 shared_ptr(nullptr_t __p, _Deleter __d)
        : __shared_ptr<_Tp>(__p, std::move(__d)) { }
      template<typename _Yp, typename _Deleter, typename _Alloc,
        typename = _Constructible<_Yp*, _Deleter, _Alloc>>
 shared_ptr(_Yp* __p, _Deleter __d, _Alloc __a)
 : __shared_ptr<_Tp>(__p, std::move(__d), std::move(__a)) { }
      template<typename _Deleter, typename _Alloc>
 shared_ptr(nullptr_t __p, _Deleter __d, _Alloc __a)
 : __shared_ptr<_Tp>(__p, std::move(__d), std::move(__a)) { }
      template<typename _Yp>
 shared_ptr(const shared_ptr<_Yp>& __r, element_type* __p) noexcept
 : __shared_ptr<_Tp>(__r, __p) { }
      template<typename _Yp,
        typename = _Constructible<const shared_ptr<_Yp>&>>
 shared_ptr(const shared_ptr<_Yp>& __r) noexcept
        : __shared_ptr<_Tp>(__r) { }
      shared_ptr(shared_ptr&& __r) noexcept
      : __shared_ptr<_Tp>(std::move(__r)) { }
      template<typename _Yp, typename = _Constructible<shared_ptr<_Yp>>>
 shared_ptr(shared_ptr<_Yp>&& __r) noexcept
 : __shared_ptr<_Tp>(std::move(__r)) { }
      template<typename _Yp, typename = _Constructible<const weak_ptr<_Yp>&>>
 explicit shared_ptr(const weak_ptr<_Yp>& __r)
 : __shared_ptr<_Tp>(__r) { }
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
      template<typename _Yp, typename = _Constructible<auto_ptr<_Yp>>>
 shared_ptr(auto_ptr<_Yp>&& __r);
#pragma GCC diagnostic pop
      template<typename _Yp, typename _Del,
        typename = _Constructible<unique_ptr<_Yp, _Del>>>
 shared_ptr(unique_ptr<_Yp, _Del>&& __r)
 : __shared_ptr<_Tp>(std::move(__r)) { }
      template<typename _Yp, typename _Del,
  _Constructible<unique_ptr<_Yp, _Del>, __sp_array_delete>* = 0>
 shared_ptr(unique_ptr<_Yp, _Del>&& __r)
 : __shared_ptr<_Tp>(std::move(__r), __sp_array_delete()) { }
      constexpr shared_ptr(nullptr_t) noexcept : shared_ptr() { }
      shared_ptr& operator=(const shared_ptr&) noexcept = default;
      template<typename _Yp>
 _Assignable<const shared_ptr<_Yp>&>
 operator=(const shared_ptr<_Yp>& __r) noexcept
 {
   this->__shared_ptr<_Tp>::operator=(__r);
   return *this;
 }
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
      template<typename _Yp>
 _Assignable<auto_ptr<_Yp>>
 operator=(auto_ptr<_Yp>&& __r)
 {
   this->__shared_ptr<_Tp>::operator=(std::move(__r));
   return *this;
 }
#pragma GCC diagnostic pop
      shared_ptr&
      operator=(shared_ptr&& __r) noexcept
      {
 this->__shared_ptr<_Tp>::operator=(std::move(__r));
 return *this;
      }
      template<class _Yp>
 _Assignable<shared_ptr<_Yp>>
 operator=(shared_ptr<_Yp>&& __r) noexcept
 {
   this->__shared_ptr<_Tp>::operator=(std::move(__r));
   return *this;
 }
      template<typename _Yp, typename _Del>
 _Assignable<unique_ptr<_Yp, _Del>>
 operator=(unique_ptr<_Yp, _Del>&& __r)
 {
   this->__shared_ptr<_Tp>::operator=(std::move(__r));
   return *this;
 }
    private:
      template<typename _Alloc, typename... _Args>
 shared_ptr(_Sp_make_shared_tag __tag, const _Alloc& __a,
     _Args&&... __args)
 : __shared_ptr<_Tp>(__tag, __a, std::forward<_Args>(__args)...)
 { }
      template<typename _Yp, typename _Alloc, typename... _Args>
 friend shared_ptr<_Yp>
 allocate_shared(const _Alloc& __a, _Args&&... __args);
      shared_ptr(const weak_ptr<_Tp>& __r, std::nothrow_t)
      : __shared_ptr<_Tp>(__r, std::nothrow) { }
      friend class weak_ptr<_Tp>;
    };
  template<typename _Tp, typename _Up>
    inline bool
    operator==(const shared_ptr<_Tp>& __a, const shared_ptr<_Up>& __b) noexcept
    { return __a.get() == __b.get(); }
  template<typename _Tp>
    inline bool
    operator==(const shared_ptr<_Tp>& __a, nullptr_t) noexcept
    { return !__a; }
  template<typename _Tp>
    inline bool
    operator==(nullptr_t, const shared_ptr<_Tp>& __a) noexcept
    { return !__a; }
  template<typename _Tp, typename _Up>
    inline bool
    operator!=(const shared_ptr<_Tp>& __a, const shared_ptr<_Up>& __b) noexcept
    { return __a.get() != __b.get(); }
  template<typename _Tp>
    inline bool
    operator!=(const shared_ptr<_Tp>& __a, nullptr_t) noexcept
    { return (bool)__a; }
  template<typename _Tp>
    inline bool
    operator!=(nullptr_t, const shared_ptr<_Tp>& __a) noexcept
    { return (bool)__a; }
  template<typename _Tp, typename _Up>
    inline bool
    operator<(const shared_ptr<_Tp>& __a, const shared_ptr<_Up>& __b) noexcept
    {
      using _Tp_elt = typename shared_ptr<_Tp>::element_type;
      using _Up_elt = typename shared_ptr<_Up>::element_type;
      using _Vp = typename common_type<_Tp_elt*, _Up_elt*>::type;
      return less<_Vp>()(__a.get(), __b.get());
    }
  template<typename _Tp>
    inline bool
    operator<(const shared_ptr<_Tp>& __a, nullptr_t) noexcept
    {
      using _Tp_elt = typename shared_ptr<_Tp>::element_type;
      return less<_Tp_elt*>()(__a.get(), nullptr);
    }
  template<typename _Tp>
    inline bool
    operator<(nullptr_t, const shared_ptr<_Tp>& __a) noexcept
    {
      using _Tp_elt = typename shared_ptr<_Tp>::element_type;
      return less<_Tp_elt*>()(nullptr, __a.get());
    }
  template<typename _Tp, typename _Up>
    inline bool
    operator<=(const shared_ptr<_Tp>& __a, const shared_ptr<_Up>& __b) noexcept
    { return !(__b < __a); }
  template<typename _Tp>
    inline bool
    operator<=(const shared_ptr<_Tp>& __a, nullptr_t) noexcept
    { return !(nullptr < __a); }
  template<typename _Tp>
    inline bool
    operator<=(nullptr_t, const shared_ptr<_Tp>& __a) noexcept
    { return !(__a < nullptr); }
  template<typename _Tp, typename _Up>
    inline bool
    operator>(const shared_ptr<_Tp>& __a, const shared_ptr<_Up>& __b) noexcept
    { return (__b < __a); }
  template<typename _Tp>
    inline bool
    operator>(const shared_ptr<_Tp>& __a, nullptr_t) noexcept
    { return nullptr < __a; }
  template<typename _Tp>
    inline bool
    operator>(nullptr_t, const shared_ptr<_Tp>& __a) noexcept
    { return __a < nullptr; }
  template<typename _Tp, typename _Up>
    inline bool
    operator>=(const shared_ptr<_Tp>& __a, const shared_ptr<_Up>& __b) noexcept
    { return !(__a < __b); }
  template<typename _Tp>
    inline bool
    operator>=(const shared_ptr<_Tp>& __a, nullptr_t) noexcept
    { return !(__a < nullptr); }
  template<typename _Tp>
    inline bool
    operator>=(nullptr_t, const shared_ptr<_Tp>& __a) noexcept
    { return !(nullptr < __a); }
  template<typename _Tp>
    struct less<shared_ptr<_Tp>> : public _Sp_less<shared_ptr<_Tp>>
    { };
  template<typename _Tp>
    inline void
    swap(shared_ptr<_Tp>& __a, shared_ptr<_Tp>& __b) noexcept
    { __a.swap(__b); }
  template<typename _Tp, typename _Up>
    inline shared_ptr<_Tp>
    static_pointer_cast(const shared_ptr<_Up>& __r) noexcept
    {
      using _Sp = shared_ptr<_Tp>;
      return _Sp(__r, static_cast<typename _Sp::element_type*>(__r.get()));
    }
  template<typename _Tp, typename _Up>
    inline shared_ptr<_Tp>
    const_pointer_cast(const shared_ptr<_Up>& __r) noexcept
    {
      using _Sp = shared_ptr<_Tp>;
      return _Sp(__r, const_cast<typename _Sp::element_type*>(__r.get()));
    }
  template<typename _Tp, typename _Up>
    inline shared_ptr<_Tp>
    dynamic_pointer_cast(const shared_ptr<_Up>& __r) noexcept
    {
      using _Sp = shared_ptr<_Tp>;
      if (auto* __p = dynamic_cast<typename _Sp::element_type*>(__r.get()))
 return _Sp(__r, __p);
      return _Sp();
    }
  template<typename _Tp>
    class weak_ptr : public __weak_ptr<_Tp>
    {
      template<typename _Arg>
 using _Constructible = typename enable_if<
   is_constructible<__weak_ptr<_Tp>, _Arg>::value
 >::type;
      template<typename _Arg>
 using _Assignable = typename enable_if<
   is_assignable<__weak_ptr<_Tp>&, _Arg>::value, weak_ptr&
 >::type;
    public:
      constexpr weak_ptr() noexcept = default;
      template<typename _Yp,
        typename = _Constructible<const shared_ptr<_Yp>&>>
 weak_ptr(const shared_ptr<_Yp>& __r) noexcept
 : __weak_ptr<_Tp>(__r) { }
      weak_ptr(const weak_ptr&) noexcept = default;
      template<typename _Yp, typename = _Constructible<const weak_ptr<_Yp>&>>
 weak_ptr(const weak_ptr<_Yp>& __r) noexcept
 : __weak_ptr<_Tp>(__r) { }
      weak_ptr(weak_ptr&&) noexcept = default;
      template<typename _Yp, typename = _Constructible<weak_ptr<_Yp>>>
 weak_ptr(weak_ptr<_Yp>&& __r) noexcept
 : __weak_ptr<_Tp>(std::move(__r)) { }
      weak_ptr&
      operator=(const weak_ptr& __r) noexcept = default;
      template<typename _Yp>
 _Assignable<const weak_ptr<_Yp>&>
 operator=(const weak_ptr<_Yp>& __r) noexcept
 {
   this->__weak_ptr<_Tp>::operator=(__r);
   return *this;
 }
      template<typename _Yp>
 _Assignable<const shared_ptr<_Yp>&>
 operator=(const shared_ptr<_Yp>& __r) noexcept
 {
   this->__weak_ptr<_Tp>::operator=(__r);
   return *this;
 }
      weak_ptr&
      operator=(weak_ptr&& __r) noexcept = default;
      template<typename _Yp>
 _Assignable<weak_ptr<_Yp>>
 operator=(weak_ptr<_Yp>&& __r) noexcept
 {
   this->__weak_ptr<_Tp>::operator=(std::move(__r));
   return *this;
 }
      shared_ptr<_Tp>
      lock() const noexcept
      { return shared_ptr<_Tp>(*this, std::nothrow); }
    };
  template<typename _Tp>
    inline void
    swap(weak_ptr<_Tp>& __a, weak_ptr<_Tp>& __b) noexcept
    { __a.swap(__b); }
  template<typename _Tp = void>
    struct owner_less;
  template<>
    struct owner_less<void> : _Sp_owner_less<void, void>
    { };
  template<typename _Tp>
    struct owner_less<shared_ptr<_Tp>>
    : public _Sp_owner_less<shared_ptr<_Tp>, weak_ptr<_Tp>>
    { };
  template<typename _Tp>
    struct owner_less<weak_ptr<_Tp>>
    : public _Sp_owner_less<weak_ptr<_Tp>, shared_ptr<_Tp>>
    { };
  template<typename _Tp>
    class enable_shared_from_this
    {
    protected:
      constexpr enable_shared_from_this() noexcept { }
      enable_shared_from_this(const enable_shared_from_this&) noexcept { }
      enable_shared_from_this&
      operator=(const enable_shared_from_this&) noexcept
      { return *this; }
      ~enable_shared_from_this() { }
    public:
      shared_ptr<_Tp>
      shared_from_this()
      { return shared_ptr<_Tp>(this->_M_weak_this); }
      shared_ptr<const _Tp>
      shared_from_this() const
      { return shared_ptr<const _Tp>(this->_M_weak_this); }
      weak_ptr<_Tp>
      weak_from_this() noexcept
      { return this->_M_weak_this; }
      weak_ptr<const _Tp>
      weak_from_this() const noexcept
      { return this->_M_weak_this; }
    private:
      template<typename _Tp1>
 void
 _M_weak_assign(_Tp1* __p, const __shared_count<>& __n) const noexcept
 { _M_weak_this._M_assign(__p, __n); }
      friend const enable_shared_from_this*
      __enable_shared_from_this_base(const __shared_count<>&,
         const enable_shared_from_this* __p)
      { return __p; }
      template<typename, _Lock_policy>
 friend class __shared_ptr;
      mutable weak_ptr<_Tp> _M_weak_this;
    };
  template<typename _Tp, typename _Alloc, typename... _Args>
    inline shared_ptr<_Tp>
    allocate_shared(const _Alloc& __a, _Args&&... __args)
    {
      return shared_ptr<_Tp>(_Sp_make_shared_tag(), __a,
        std::forward<_Args>(__args)...);
    }
  template<typename _Tp, typename... _Args>
    inline shared_ptr<_Tp>
    make_shared(_Args&&... __args)
    {
      typedef typename std::remove_const<_Tp>::type _Tp_nc;
      return std::allocate_shared<_Tp>(std::allocator<_Tp_nc>(),
           std::forward<_Args>(__args)...);
    }
  template<typename _Tp>
    struct hash<shared_ptr<_Tp>>
    : public __hash_base<size_t, shared_ptr<_Tp>>
    {
      size_t
      operator()(const shared_ptr<_Tp>& __s) const noexcept
      {
 return std::hash<typename shared_ptr<_Tp>::element_type*>()(__s.get());
      }
    };

}
       
       
namespace std
{

  typedef enum memory_order
    {
      memory_order_relaxed,
      memory_order_consume,
      memory_order_acquire,
      memory_order_release,
      memory_order_acq_rel,
      memory_order_seq_cst
    } memory_order;
  enum __memory_order_modifier
    {
      __memory_order_mask = 0x0ffff,
      __memory_order_modifier_mask = 0xffff0000,
      __memory_order_hle_acquire = 0x10000,
      __memory_order_hle_release = 0x20000
    };
  constexpr memory_order
  operator|(memory_order __m, __memory_order_modifier __mod)
  {
    return memory_order(__m | int(__mod));
  }
  constexpr memory_order
  operator&(memory_order __m, __memory_order_modifier __mod)
  {
    return memory_order(__m & int(__mod));
  }
  constexpr memory_order
  __cmpexch_failure_order2(memory_order __m) noexcept
  {
    return __m == memory_order_acq_rel ? memory_order_acquire
      : __m == memory_order_release ? memory_order_relaxed : __m;
  }
  constexpr memory_order
  __cmpexch_failure_order(memory_order __m) noexcept
  {
    return memory_order(__cmpexch_failure_order2(__m & __memory_order_mask)
      | (__m & __memory_order_modifier_mask));
  }
  inline __attribute__((__always_inline__)) void
  atomic_thread_fence(memory_order __m) noexcept
  { __atomic_thread_fence(__m); }
  inline __attribute__((__always_inline__)) void
  atomic_signal_fence(memory_order __m) noexcept
  { __atomic_signal_fence(__m); }
  template<typename _Tp>
    inline _Tp
    kill_dependency(_Tp __y) noexcept
    {
      _Tp __ret(__y);
      return __ret;
    }
  template<typename _IntTp>
    struct __atomic_base;
  template<typename _Tp>
    struct atomic;
  template<typename _Tp>
    struct atomic<_Tp*>;
    typedef bool __atomic_flag_data_type;
  extern "C" {
  struct __atomic_flag_base
  {
    __atomic_flag_data_type _M_i;
  };
  }
  struct atomic_flag : public __atomic_flag_base
  {
    atomic_flag() noexcept = default;
    ~atomic_flag() noexcept = default;
    atomic_flag(const atomic_flag&) = delete;
    atomic_flag& operator=(const atomic_flag&) = delete;
    atomic_flag& operator=(const atomic_flag&) volatile = delete;
    constexpr atomic_flag(bool __i) noexcept
      : __atomic_flag_base{ _S_init(__i) }
    { }
    inline __attribute__((__always_inline__)) bool
    test_and_set(memory_order __m = memory_order_seq_cst) noexcept
    {
      return __atomic_test_and_set (&_M_i, __m);
    }
    inline __attribute__((__always_inline__)) bool
    test_and_set(memory_order __m = memory_order_seq_cst) volatile noexcept
    {
      return __atomic_test_and_set (&_M_i, __m);
    }
    inline __attribute__((__always_inline__)) void
    clear(memory_order __m = memory_order_seq_cst) noexcept
    {
      memory_order __b = __m & __memory_order_mask;
      ;
      ;
      ;
      __atomic_clear (&_M_i, __m);
    }
    inline __attribute__((__always_inline__)) void
    clear(memory_order __m = memory_order_seq_cst) volatile noexcept
    {
      memory_order __b = __m & __memory_order_mask;
      ;
      ;
      ;
      __atomic_clear (&_M_i, __m);
    }
  private:
    static constexpr __atomic_flag_data_type
    _S_init(bool __i)
    { return __i ? 1 : 0; }
  };
  template<typename _ITp>
    struct __atomic_base
    {
    private:
      typedef _ITp __int_type;
      static constexpr int _S_alignment =
 sizeof(_ITp) > alignof(_ITp) ? sizeof(_ITp) : alignof(_ITp);
      alignas(_S_alignment) __int_type _M_i;
    public:
      __atomic_base() noexcept = default;
      ~__atomic_base() noexcept = default;
      __atomic_base(const __atomic_base&) = delete;
      __atomic_base& operator=(const __atomic_base&) = delete;
      __atomic_base& operator=(const __atomic_base&) volatile = delete;
      constexpr __atomic_base(__int_type __i) noexcept : _M_i (__i) { }
      operator __int_type() const noexcept
      { return load(); }
      operator __int_type() const volatile noexcept
      { return load(); }
      __int_type
      operator=(__int_type __i) noexcept
      {
 store(__i);
 return __i;
      }
      __int_type
      operator=(__int_type __i) volatile noexcept
      {
 store(__i);
 return __i;
      }
      __int_type
      operator++(int) noexcept
      { return fetch_add(1); }
      __int_type
      operator++(int) volatile noexcept
      { return fetch_add(1); }
      __int_type
      operator--(int) noexcept
      { return fetch_sub(1); }
      __int_type
      operator--(int) volatile noexcept
      { return fetch_sub(1); }
      __int_type
      operator++() noexcept
      { return __atomic_add_fetch(&_M_i, 1, memory_order_seq_cst); }
      __int_type
      operator++() volatile noexcept
      { return __atomic_add_fetch(&_M_i, 1, memory_order_seq_cst); }
      __int_type
      operator--() noexcept
      { return __atomic_sub_fetch(&_M_i, 1, memory_order_seq_cst); }
      __int_type
      operator--() volatile noexcept
      { return __atomic_sub_fetch(&_M_i, 1, memory_order_seq_cst); }
      __int_type
      operator+=(__int_type __i) noexcept
      { return __atomic_add_fetch(&_M_i, __i, memory_order_seq_cst); }
      __int_type
      operator+=(__int_type __i) volatile noexcept
      { return __atomic_add_fetch(&_M_i, __i, memory_order_seq_cst); }
      __int_type
      operator-=(__int_type __i) noexcept
      { return __atomic_sub_fetch(&_M_i, __i, memory_order_seq_cst); }
      __int_type
      operator-=(__int_type __i) volatile noexcept
      { return __atomic_sub_fetch(&_M_i, __i, memory_order_seq_cst); }
      __int_type
      operator&=(__int_type __i) noexcept
      { return __atomic_and_fetch(&_M_i, __i, memory_order_seq_cst); }
      __int_type
      operator&=(__int_type __i) volatile noexcept
      { return __atomic_and_fetch(&_M_i, __i, memory_order_seq_cst); }
      __int_type
      operator|=(__int_type __i) noexcept
      { return __atomic_or_fetch(&_M_i, __i, memory_order_seq_cst); }
      __int_type
      operator|=(__int_type __i) volatile noexcept
      { return __atomic_or_fetch(&_M_i, __i, memory_order_seq_cst); }
      __int_type
      operator^=(__int_type __i) noexcept
      { return __atomic_xor_fetch(&_M_i, __i, memory_order_seq_cst); }
      __int_type
      operator^=(__int_type __i) volatile noexcept
      { return __atomic_xor_fetch(&_M_i, __i, memory_order_seq_cst); }
      bool
      is_lock_free() const noexcept
      {
 return __atomic_is_lock_free(sizeof(_M_i),
     reinterpret_cast<void *>(-__alignof(_M_i)));
      }
      bool
      is_lock_free() const volatile noexcept
      {
 return __atomic_is_lock_free(sizeof(_M_i),
     reinterpret_cast<void *>(-__alignof(_M_i)));
      }
      inline __attribute__((__always_inline__)) void
      store(__int_type __i, memory_order __m = memory_order_seq_cst) noexcept
      {
 memory_order __b = __m & __memory_order_mask;
 ;
 ;
 ;
 __atomic_store_n(&_M_i, __i, __m);
      }
      inline __attribute__((__always_inline__)) void
      store(__int_type __i,
     memory_order __m = memory_order_seq_cst) volatile noexcept
      {
 memory_order __b = __m & __memory_order_mask;
 ;
 ;
 ;
 __atomic_store_n(&_M_i, __i, __m);
      }
      inline __attribute__((__always_inline__)) __int_type
      load(memory_order __m = memory_order_seq_cst) const noexcept
      {
 memory_order __b = __m & __memory_order_mask;
 ;
 ;
 return __atomic_load_n(&_M_i, __m);
      }
      inline __attribute__((__always_inline__)) __int_type
      load(memory_order __m = memory_order_seq_cst) const volatile noexcept
      {
 memory_order __b = __m & __memory_order_mask;
 ;
 ;
 return __atomic_load_n(&_M_i, __m);
      }
      inline __attribute__((__always_inline__)) __int_type
      exchange(__int_type __i,
        memory_order __m = memory_order_seq_cst) noexcept
      {
 return __atomic_exchange_n(&_M_i, __i, __m);
      }
      inline __attribute__((__always_inline__)) __int_type
      exchange(__int_type __i,
        memory_order __m = memory_order_seq_cst) volatile noexcept
      {
 return __atomic_exchange_n(&_M_i, __i, __m);
      }
      inline __attribute__((__always_inline__)) bool
      compare_exchange_weak(__int_type& __i1, __int_type __i2,
       memory_order __m1, memory_order __m2) noexcept
      {
 memory_order __b2 = __m2 & __memory_order_mask;
 memory_order __b1 = __m1 & __memory_order_mask;
 ;
 ;
 ;
 return __atomic_compare_exchange_n(&_M_i, &__i1, __i2, 1, __m1, __m2);
      }
      inline __attribute__((__always_inline__)) bool
      compare_exchange_weak(__int_type& __i1, __int_type __i2,
       memory_order __m1,
       memory_order __m2) volatile noexcept
      {
 memory_order __b2 = __m2 & __memory_order_mask;
 memory_order __b1 = __m1 & __memory_order_mask;
 ;
 ;
 ;
 return __atomic_compare_exchange_n(&_M_i, &__i1, __i2, 1, __m1, __m2);
      }
      inline __attribute__((__always_inline__)) bool
      compare_exchange_weak(__int_type& __i1, __int_type __i2,
       memory_order __m = memory_order_seq_cst) noexcept
      {
 return compare_exchange_weak(__i1, __i2, __m,
         __cmpexch_failure_order(__m));
      }
      inline __attribute__((__always_inline__)) bool
      compare_exchange_weak(__int_type& __i1, __int_type __i2,
     memory_order __m = memory_order_seq_cst) volatile noexcept
      {
 return compare_exchange_weak(__i1, __i2, __m,
         __cmpexch_failure_order(__m));
      }
      inline __attribute__((__always_inline__)) bool
      compare_exchange_strong(__int_type& __i1, __int_type __i2,
         memory_order __m1, memory_order __m2) noexcept
      {
 memory_order __b2 = __m2 & __memory_order_mask;
 memory_order __b1 = __m1 & __memory_order_mask;
 ;
 ;
 ;
 return __atomic_compare_exchange_n(&_M_i, &__i1, __i2, 0, __m1, __m2);
      }
      inline __attribute__((__always_inline__)) bool
      compare_exchange_strong(__int_type& __i1, __int_type __i2,
         memory_order __m1,
         memory_order __m2) volatile noexcept
      {
 memory_order __b2 = __m2 & __memory_order_mask;
 memory_order __b1 = __m1 & __memory_order_mask;
 ;
 ;
 ;
 return __atomic_compare_exchange_n(&_M_i, &__i1, __i2, 0, __m1, __m2);
      }
      inline __attribute__((__always_inline__)) bool
      compare_exchange_strong(__int_type& __i1, __int_type __i2,
         memory_order __m = memory_order_seq_cst) noexcept
      {
 return compare_exchange_strong(__i1, __i2, __m,
           __cmpexch_failure_order(__m));
      }
      inline __attribute__((__always_inline__)) bool
      compare_exchange_strong(__int_type& __i1, __int_type __i2,
   memory_order __m = memory_order_seq_cst) volatile noexcept
      {
 return compare_exchange_strong(__i1, __i2, __m,
           __cmpexch_failure_order(__m));
      }
      inline __attribute__((__always_inline__)) __int_type
      fetch_add(__int_type __i,
  memory_order __m = memory_order_seq_cst) noexcept
      { return __atomic_fetch_add(&_M_i, __i, __m); }
      inline __attribute__((__always_inline__)) __int_type
      fetch_add(__int_type __i,
  memory_order __m = memory_order_seq_cst) volatile noexcept
      { return __atomic_fetch_add(&_M_i, __i, __m); }
      inline __attribute__((__always_inline__)) __int_type
      fetch_sub(__int_type __i,
  memory_order __m = memory_order_seq_cst) noexcept
      { return __atomic_fetch_sub(&_M_i, __i, __m); }
      inline __attribute__((__always_inline__)) __int_type
      fetch_sub(__int_type __i,
  memory_order __m = memory_order_seq_cst) volatile noexcept
      { return __atomic_fetch_sub(&_M_i, __i, __m); }
      inline __attribute__((__always_inline__)) __int_type
      fetch_and(__int_type __i,
  memory_order __m = memory_order_seq_cst) noexcept
      { return __atomic_fetch_and(&_M_i, __i, __m); }
      inline __attribute__((__always_inline__)) __int_type
      fetch_and(__int_type __i,
  memory_order __m = memory_order_seq_cst) volatile noexcept
      { return __atomic_fetch_and(&_M_i, __i, __m); }
      inline __attribute__((__always_inline__)) __int_type
      fetch_or(__int_type __i,
        memory_order __m = memory_order_seq_cst) noexcept
      { return __atomic_fetch_or(&_M_i, __i, __m); }
      inline __attribute__((__always_inline__)) __int_type
      fetch_or(__int_type __i,
        memory_order __m = memory_order_seq_cst) volatile noexcept
      { return __atomic_fetch_or(&_M_i, __i, __m); }
      inline __attribute__((__always_inline__)) __int_type
      fetch_xor(__int_type __i,
  memory_order __m = memory_order_seq_cst) noexcept
      { return __atomic_fetch_xor(&_M_i, __i, __m); }
      inline __attribute__((__always_inline__)) __int_type
      fetch_xor(__int_type __i,
  memory_order __m = memory_order_seq_cst) volatile noexcept
      { return __atomic_fetch_xor(&_M_i, __i, __m); }
    };
  template<typename _PTp>
    struct __atomic_base<_PTp*>
    {
    private:
      typedef _PTp* __pointer_type;
      __pointer_type _M_p;
      constexpr ptrdiff_t
      _M_type_size(ptrdiff_t __d) const { return __d * sizeof(_PTp); }
      constexpr ptrdiff_t
      _M_type_size(ptrdiff_t __d) const volatile { return __d * sizeof(_PTp); }
    public:
      __atomic_base() noexcept = default;
      ~__atomic_base() noexcept = default;
      __atomic_base(const __atomic_base&) = delete;
      __atomic_base& operator=(const __atomic_base&) = delete;
      __atomic_base& operator=(const __atomic_base&) volatile = delete;
      constexpr __atomic_base(__pointer_type __p) noexcept : _M_p (__p) { }
      operator __pointer_type() const noexcept
      { return load(); }
      operator __pointer_type() const volatile noexcept
      { return load(); }
      __pointer_type
      operator=(__pointer_type __p) noexcept
      {
 store(__p);
 return __p;
      }
      __pointer_type
      operator=(__pointer_type __p) volatile noexcept
      {
 store(__p);
 return __p;
      }
      __pointer_type
      operator++(int) noexcept
      { return fetch_add(1); }
      __pointer_type
      operator++(int) volatile noexcept
      { return fetch_add(1); }
      __pointer_type
      operator--(int) noexcept
      { return fetch_sub(1); }
      __pointer_type
      operator--(int) volatile noexcept
      { return fetch_sub(1); }
      __pointer_type
      operator++() noexcept
      { return __atomic_add_fetch(&_M_p, _M_type_size(1),
      memory_order_seq_cst); }
      __pointer_type
      operator++() volatile noexcept
      { return __atomic_add_fetch(&_M_p, _M_type_size(1),
      memory_order_seq_cst); }
      __pointer_type
      operator--() noexcept
      { return __atomic_sub_fetch(&_M_p, _M_type_size(1),
      memory_order_seq_cst); }
      __pointer_type
      operator--() volatile noexcept
      { return __atomic_sub_fetch(&_M_p, _M_type_size(1),
      memory_order_seq_cst); }
      __pointer_type
      operator+=(ptrdiff_t __d) noexcept
      { return __atomic_add_fetch(&_M_p, _M_type_size(__d),
      memory_order_seq_cst); }
      __pointer_type
      operator+=(ptrdiff_t __d) volatile noexcept
      { return __atomic_add_fetch(&_M_p, _M_type_size(__d),
      memory_order_seq_cst); }
      __pointer_type
      operator-=(ptrdiff_t __d) noexcept
      { return __atomic_sub_fetch(&_M_p, _M_type_size(__d),
      memory_order_seq_cst); }
      __pointer_type
      operator-=(ptrdiff_t __d) volatile noexcept
      { return __atomic_sub_fetch(&_M_p, _M_type_size(__d),
      memory_order_seq_cst); }
      bool
      is_lock_free() const noexcept
      {
 return __atomic_is_lock_free(sizeof(_M_p),
     reinterpret_cast<void *>(-__alignof(_M_p)));
      }
      bool
      is_lock_free() const volatile noexcept
      {
 return __atomic_is_lock_free(sizeof(_M_p),
     reinterpret_cast<void *>(-__alignof(_M_p)));
      }
      inline __attribute__((__always_inline__)) void
      store(__pointer_type __p,
     memory_order __m = memory_order_seq_cst) noexcept
      {
        memory_order __b = __m & __memory_order_mask;
 ;
 ;
 ;
 __atomic_store_n(&_M_p, __p, __m);
      }
      inline __attribute__((__always_inline__)) void
      store(__pointer_type __p,
     memory_order __m = memory_order_seq_cst) volatile noexcept
      {
 memory_order __b = __m & __memory_order_mask;
 ;
 ;
 ;
 __atomic_store_n(&_M_p, __p, __m);
      }
      inline __attribute__((__always_inline__)) __pointer_type
      load(memory_order __m = memory_order_seq_cst) const noexcept
      {
 memory_order __b = __m & __memory_order_mask;
 ;
 ;
 return __atomic_load_n(&_M_p, __m);
      }
      inline __attribute__((__always_inline__)) __pointer_type
      load(memory_order __m = memory_order_seq_cst) const volatile noexcept
      {
 memory_order __b = __m & __memory_order_mask;
 ;
 ;
 return __atomic_load_n(&_M_p, __m);
      }
      inline __attribute__((__always_inline__)) __pointer_type
      exchange(__pointer_type __p,
        memory_order __m = memory_order_seq_cst) noexcept
      {
 return __atomic_exchange_n(&_M_p, __p, __m);
      }
      inline __attribute__((__always_inline__)) __pointer_type
      exchange(__pointer_type __p,
        memory_order __m = memory_order_seq_cst) volatile noexcept
      {
 return __atomic_exchange_n(&_M_p, __p, __m);
      }
      inline __attribute__((__always_inline__)) bool
      compare_exchange_strong(__pointer_type& __p1, __pointer_type __p2,
         memory_order __m1,
         memory_order __m2) noexcept
      {
 memory_order __b2 = __m2 & __memory_order_mask;
 memory_order __b1 = __m1 & __memory_order_mask;
 ;
 ;
 ;
 return __atomic_compare_exchange_n(&_M_p, &__p1, __p2, 0, __m1, __m2);
      }
      inline __attribute__((__always_inline__)) bool
      compare_exchange_strong(__pointer_type& __p1, __pointer_type __p2,
         memory_order __m1,
         memory_order __m2) volatile noexcept
      {
 memory_order __b2 = __m2 & __memory_order_mask;
 memory_order __b1 = __m1 & __memory_order_mask;
 ;
 ;
 ;
 return __atomic_compare_exchange_n(&_M_p, &__p1, __p2, 0, __m1, __m2);
      }
      inline __attribute__((__always_inline__)) __pointer_type
      fetch_add(ptrdiff_t __d,
  memory_order __m = memory_order_seq_cst) noexcept
      { return __atomic_fetch_add(&_M_p, _M_type_size(__d), __m); }
      inline __attribute__((__always_inline__)) __pointer_type
      fetch_add(ptrdiff_t __d,
  memory_order __m = memory_order_seq_cst) volatile noexcept
      { return __atomic_fetch_add(&_M_p, _M_type_size(__d), __m); }
      inline __attribute__((__always_inline__)) __pointer_type
      fetch_sub(ptrdiff_t __d,
  memory_order __m = memory_order_seq_cst) noexcept
      { return __atomic_fetch_sub(&_M_p, _M_type_size(__d), __m); }
      inline __attribute__((__always_inline__)) __pointer_type
      fetch_sub(ptrdiff_t __d,
  memory_order __m = memory_order_seq_cst) volatile noexcept
      { return __atomic_fetch_sub(&_M_p, _M_type_size(__d), __m); }
    };

}
namespace std
{

  struct _Sp_locker
  {
    _Sp_locker(const _Sp_locker&) = delete;
    _Sp_locker& operator=(const _Sp_locker&) = delete;
    explicit
    _Sp_locker(const void*) noexcept;
    _Sp_locker(const void*, const void*) noexcept;
    ~_Sp_locker();
  private:
    unsigned char _M_key1;
    unsigned char _M_key2;
  };
  template<typename _Tp, _Lock_policy _Lp>
    inline bool
    atomic_is_lock_free(const __shared_ptr<_Tp, _Lp>* __p)
    {
      return __gthread_active_p() == 0;
    }
  template<typename _Tp>
    inline bool
    atomic_is_lock_free(const shared_ptr<_Tp>* __p)
    { return std::atomic_is_lock_free<_Tp, __default_lock_policy>(__p); }
  template<typename _Tp>
    inline shared_ptr<_Tp>
    atomic_load_explicit(const shared_ptr<_Tp>* __p, memory_order)
    {
      _Sp_locker __lock{__p};
      return *__p;
    }
  template<typename _Tp>
    inline shared_ptr<_Tp>
    atomic_load(const shared_ptr<_Tp>* __p)
    { return std::atomic_load_explicit(__p, memory_order_seq_cst); }
  template<typename _Tp, _Lock_policy _Lp>
    inline __shared_ptr<_Tp, _Lp>
    atomic_load_explicit(const __shared_ptr<_Tp, _Lp>* __p, memory_order)
    {
      _Sp_locker __lock{__p};
      return *__p;
    }
  template<typename _Tp, _Lock_policy _Lp>
    inline __shared_ptr<_Tp, _Lp>
    atomic_load(const __shared_ptr<_Tp, _Lp>* __p)
    { return std::atomic_load_explicit(__p, memory_order_seq_cst); }
  template<typename _Tp>
    inline void
    atomic_store_explicit(shared_ptr<_Tp>* __p, shared_ptr<_Tp> __r,
     memory_order)
    {
      _Sp_locker __lock{__p};
      __p->swap(__r);
    }
  template<typename _Tp>
    inline void
    atomic_store(shared_ptr<_Tp>* __p, shared_ptr<_Tp> __r)
    { std::atomic_store_explicit(__p, std::move(__r), memory_order_seq_cst); }
  template<typename _Tp, _Lock_policy _Lp>
    inline void
    atomic_store_explicit(__shared_ptr<_Tp, _Lp>* __p,
     __shared_ptr<_Tp, _Lp> __r,
     memory_order)
    {
      _Sp_locker __lock{__p};
      __p->swap(__r);
    }
  template<typename _Tp, _Lock_policy _Lp>
    inline void
    atomic_store(__shared_ptr<_Tp, _Lp>* __p, __shared_ptr<_Tp, _Lp> __r)
    { std::atomic_store_explicit(__p, std::move(__r), memory_order_seq_cst); }
  template<typename _Tp>
    inline shared_ptr<_Tp>
    atomic_exchange_explicit(shared_ptr<_Tp>* __p, shared_ptr<_Tp> __r,
        memory_order)
    {
      _Sp_locker __lock{__p};
      __p->swap(__r);
      return __r;
    }
  template<typename _Tp>
    inline shared_ptr<_Tp>
    atomic_exchange(shared_ptr<_Tp>* __p, shared_ptr<_Tp> __r)
    {
      return std::atomic_exchange_explicit(__p, std::move(__r),
        memory_order_seq_cst);
    }
  template<typename _Tp, _Lock_policy _Lp>
    inline __shared_ptr<_Tp, _Lp>
    atomic_exchange_explicit(__shared_ptr<_Tp, _Lp>* __p,
        __shared_ptr<_Tp, _Lp> __r,
        memory_order)
    {
      _Sp_locker __lock{__p};
      __p->swap(__r);
      return __r;
    }
  template<typename _Tp, _Lock_policy _Lp>
    inline __shared_ptr<_Tp, _Lp>
    atomic_exchange(__shared_ptr<_Tp, _Lp>* __p, __shared_ptr<_Tp, _Lp> __r)
    {
      return std::atomic_exchange_explicit(__p, std::move(__r),
        memory_order_seq_cst);
    }
  template<typename _Tp>
    bool
    atomic_compare_exchange_strong_explicit(shared_ptr<_Tp>* __p,
         shared_ptr<_Tp>* __v,
         shared_ptr<_Tp> __w,
         memory_order,
         memory_order)
    {
      shared_ptr<_Tp> __x;
      _Sp_locker __lock{__p, __v};
      owner_less<shared_ptr<_Tp>> __less;
      if (*__p == *__v && !__less(*__p, *__v) && !__less(*__v, *__p))
 {
   __x = std::move(*__p);
   *__p = std::move(__w);
   return true;
 }
      __x = std::move(*__v);
      *__v = *__p;
      return false;
    }
  template<typename _Tp>
    inline bool
    atomic_compare_exchange_strong(shared_ptr<_Tp>* __p, shared_ptr<_Tp>* __v,
     shared_ptr<_Tp> __w)
    {
      return std::atomic_compare_exchange_strong_explicit(__p, __v,
   std::move(__w), memory_order_seq_cst, memory_order_seq_cst);
    }
  template<typename _Tp>
    inline bool
    atomic_compare_exchange_weak_explicit(shared_ptr<_Tp>* __p,
       shared_ptr<_Tp>* __v,
       shared_ptr<_Tp> __w,
       memory_order __success,
       memory_order __failure)
    {
      return std::atomic_compare_exchange_strong_explicit(__p, __v,
   std::move(__w), __success, __failure);
    }
  template<typename _Tp>
    inline bool
    atomic_compare_exchange_weak(shared_ptr<_Tp>* __p, shared_ptr<_Tp>* __v,
     shared_ptr<_Tp> __w)
    {
      return std::atomic_compare_exchange_weak_explicit(__p, __v,
   std::move(__w), memory_order_seq_cst, memory_order_seq_cst);
    }
  template<typename _Tp, _Lock_policy _Lp>
    bool
    atomic_compare_exchange_strong_explicit(__shared_ptr<_Tp, _Lp>* __p,
         __shared_ptr<_Tp, _Lp>* __v,
         __shared_ptr<_Tp, _Lp> __w,
         memory_order,
         memory_order)
    {
      __shared_ptr<_Tp, _Lp> __x;
      _Sp_locker __lock{__p, __v};
      owner_less<__shared_ptr<_Tp, _Lp>> __less;
      if (*__p == *__v && !__less(*__p, *__v) && !__less(*__v, *__p))
 {
   __x = std::move(*__p);
   *__p = std::move(__w);
   return true;
 }
      __x = std::move(*__v);
      *__v = *__p;
      return false;
    }
  template<typename _Tp, _Lock_policy _Lp>
    inline bool
    atomic_compare_exchange_strong(__shared_ptr<_Tp, _Lp>* __p,
       __shared_ptr<_Tp, _Lp>* __v,
       __shared_ptr<_Tp, _Lp> __w)
    {
      return std::atomic_compare_exchange_strong_explicit(__p, __v,
   std::move(__w), memory_order_seq_cst, memory_order_seq_cst);
    }
  template<typename _Tp, _Lock_policy _Lp>
    inline bool
    atomic_compare_exchange_weak_explicit(__shared_ptr<_Tp, _Lp>* __p,
       __shared_ptr<_Tp, _Lp>* __v,
       __shared_ptr<_Tp, _Lp> __w,
       memory_order __success,
       memory_order __failure)
    {
      return std::atomic_compare_exchange_strong_explicit(__p, __v,
   std::move(__w), __success, __failure);
    }
  template<typename _Tp, _Lock_policy _Lp>
    inline bool
    atomic_compare_exchange_weak(__shared_ptr<_Tp, _Lp>* __p,
     __shared_ptr<_Tp, _Lp>* __v,
     __shared_ptr<_Tp, _Lp> __w)
    {
      return std::atomic_compare_exchange_weak_explicit(__p, __v,
   std::move(__w), memory_order_seq_cst, memory_order_seq_cst);
    }

}
namespace std
{

  template<typename _Tp1>
    struct auto_ptr_ref
    {
      _Tp1* _M_ptr;
      explicit
      auto_ptr_ref(_Tp1* __p): _M_ptr(__p) { }
    } __attribute__ ((__deprecated__));
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
  template<typename _Tp>
    class auto_ptr
    {
    private:
      _Tp* _M_ptr;
    public:
      typedef _Tp element_type;
      explicit
      auto_ptr(element_type* __p = 0) throw() : _M_ptr(__p) { }
      auto_ptr(auto_ptr& __a) throw() : _M_ptr(__a.release()) { }
      template<typename _Tp1>
        auto_ptr(auto_ptr<_Tp1>& __a) throw() : _M_ptr(__a.release()) { }
      auto_ptr&
      operator=(auto_ptr& __a) throw()
      {
 reset(__a.release());
 return *this;
      }
      template<typename _Tp1>
        auto_ptr&
        operator=(auto_ptr<_Tp1>& __a) throw()
        {
   reset(__a.release());
   return *this;
 }
      ~auto_ptr() { delete _M_ptr; }
      element_type&
      operator*() const throw()
      {
 ;
 return *_M_ptr;
      }
      element_type*
      operator->() const throw()
      {
 ;
 return _M_ptr;
      }
      element_type*
      get() const throw() { return _M_ptr; }
      element_type*
      release() throw()
      {
 element_type* __tmp = _M_ptr;
 _M_ptr = 0;
 return __tmp;
      }
      void
      reset(element_type* __p = 0) throw()
      {
 if (__p != _M_ptr)
   {
     delete _M_ptr;
     _M_ptr = __p;
   }
      }
      auto_ptr(auto_ptr_ref<element_type> __ref) throw()
      : _M_ptr(__ref._M_ptr) { }
      auto_ptr&
      operator=(auto_ptr_ref<element_type> __ref) throw()
      {
 if (__ref._M_ptr != this->get())
   {
     delete _M_ptr;
     _M_ptr = __ref._M_ptr;
   }
 return *this;
      }
      template<typename _Tp1>
        operator auto_ptr_ref<_Tp1>() throw()
        { return auto_ptr_ref<_Tp1>(this->release()); }
      template<typename _Tp1>
        operator auto_ptr<_Tp1>() throw()
        { return auto_ptr<_Tp1>(this->release()); }
    } __attribute__ ((__deprecated__));
  template<>
    class auto_ptr<void>
    {
    public:
      typedef void element_type;
    } __attribute__ ((__deprecated__));
  template<_Lock_policy _Lp>
  template<typename _Tp>
    inline
    __shared_count<_Lp>::__shared_count(std::auto_ptr<_Tp>&& __r)
    : _M_pi(new _Sp_counted_ptr<_Tp*, _Lp>(__r.get()))
    { __r.release(); }
  template<typename _Tp, _Lock_policy _Lp>
  template<typename _Tp1, typename>
    inline
    __shared_ptr<_Tp, _Lp>::__shared_ptr(std::auto_ptr<_Tp1>&& __r)
    : _M_ptr(__r.get()), _M_refcount()
    {
     
      static_assert( sizeof(_Tp1) > 0, "incomplete type" );
      _Tp1* __tmp = __r.get();
      _M_refcount = __shared_count<_Lp>(std::move(__r));
      _M_enable_shared_from_this_with(__tmp);
    }
  template<typename _Tp>
  template<typename _Tp1, typename>
    inline
    shared_ptr<_Tp>::shared_ptr(std::auto_ptr<_Tp1>&& __r)
    : __shared_ptr<_Tp>(std::move(__r)) { }
  template<typename _Tp, typename _Dp>
  template<typename _Up, typename>
    inline
    unique_ptr<_Tp, _Dp>::unique_ptr(auto_ptr<_Up>&& __u) noexcept
    : _M_t(__u.release(), deleter_type()) { }
#pragma GCC diagnostic pop

}
namespace std
{

inline void*
align(size_t __align, size_t __size, void*& __ptr, size_t& __space) noexcept
{
  const auto __intptr = reinterpret_cast<uintptr_t>(__ptr);
  const auto __aligned = (__intptr - 1u + __align) & -__align;
  const auto __diff = __aligned - __intptr;
  if ((__size + __diff) > __space)
    return nullptr;
  else
    {
      __space -= __diff;
      return __ptr = reinterpret_cast<void*>(__aligned);
    }
}
enum class pointer_safety { relaxed, preferred, strict };
inline void
declare_reachable(void*) { }
template <typename _Tp>
  inline _Tp*
  undeclare_reachable(_Tp* __p) { return __p; }
inline void
declare_no_pointers(char*, size_t) { }
inline void
undeclare_no_pointers(char*, size_t) { }
inline pointer_safety
get_pointer_safety() noexcept { return pointer_safety::relaxed; }

}
       
namespace std
{


  template<typename _Tp, typename _Alloc>
    struct _Vector_base
    {
      typedef typename __gnu_cxx::__alloc_traits<_Alloc>::template
 rebind<_Tp>::other _Tp_alloc_type;
      typedef typename __gnu_cxx::__alloc_traits<_Tp_alloc_type>::pointer
        pointer;
      struct _Vector_impl
      : public _Tp_alloc_type
      {
 pointer _M_start;
 pointer _M_finish;
 pointer _M_end_of_storage;
 _Vector_impl()
 : _Tp_alloc_type(), _M_start(), _M_finish(), _M_end_of_storage()
 { }
 _Vector_impl(_Tp_alloc_type const& __a) noexcept
 : _Tp_alloc_type(__a), _M_start(), _M_finish(), _M_end_of_storage()
 { }
 _Vector_impl(_Tp_alloc_type&& __a) noexcept
 : _Tp_alloc_type(std::move(__a)),
   _M_start(), _M_finish(), _M_end_of_storage()
 { }
 void _M_swap_data(_Vector_impl& __x) noexcept
 {
   std::swap(_M_start, __x._M_start);
   std::swap(_M_finish, __x._M_finish);
   std::swap(_M_end_of_storage, __x._M_end_of_storage);
 }
      };
    public:
      typedef _Alloc allocator_type;
      _Tp_alloc_type&
      _M_get_Tp_allocator() noexcept
      { return *static_cast<_Tp_alloc_type*>(&this->_M_impl); }
      const _Tp_alloc_type&
      _M_get_Tp_allocator() const noexcept
      { return *static_cast<const _Tp_alloc_type*>(&this->_M_impl); }
      allocator_type
      get_allocator() const noexcept
      { return allocator_type(_M_get_Tp_allocator()); }
      _Vector_base()
      : _M_impl() { }
      _Vector_base(const allocator_type& __a) noexcept
      : _M_impl(__a) { }
      _Vector_base(size_t __n)
      : _M_impl()
      { _M_create_storage(__n); }
      _Vector_base(size_t __n, const allocator_type& __a)
      : _M_impl(__a)
      { _M_create_storage(__n); }
      _Vector_base(_Tp_alloc_type&& __a) noexcept
      : _M_impl(std::move(__a)) { }
      _Vector_base(_Vector_base&& __x) noexcept
      : _M_impl(std::move(__x._M_get_Tp_allocator()))
      { this->_M_impl._M_swap_data(__x._M_impl); }
      _Vector_base(_Vector_base&& __x, const allocator_type& __a)
      : _M_impl(__a)
      {
 if (__x.get_allocator() == __a)
   this->_M_impl._M_swap_data(__x._M_impl);
 else
   {
     size_t __n = __x._M_impl._M_finish - __x._M_impl._M_start;
     _M_create_storage(__n);
   }
      }
      ~_Vector_base() noexcept
      {
 _M_deallocate(_M_impl._M_start,
        _M_impl._M_end_of_storage - _M_impl._M_start);
      }
    public:
      _Vector_impl _M_impl;
      pointer
      _M_allocate(size_t __n)
      {
 typedef __gnu_cxx::__alloc_traits<_Tp_alloc_type> _Tr;
 return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
      }
      void
      _M_deallocate(pointer __p, size_t __n)
      {
 typedef __gnu_cxx::__alloc_traits<_Tp_alloc_type> _Tr;
 if (__p)
   _Tr::deallocate(_M_impl, __p, __n);
      }
    private:
      void
      _M_create_storage(size_t __n)
      {
 this->_M_impl._M_start = this->_M_allocate(__n);
 this->_M_impl._M_finish = this->_M_impl._M_start;
 this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
      }
    };
  template<typename _Tp, typename _Alloc = std::allocator<_Tp> >
    class vector : protected _Vector_base<_Tp, _Alloc>
    {
      static_assert(is_same<typename remove_cv<_Tp>::type, _Tp>::value,
   "std::vector must have a non-const, non-volatile value_type");
      typedef _Vector_base<_Tp, _Alloc> _Base;
      typedef typename _Base::_Tp_alloc_type _Tp_alloc_type;
      typedef __gnu_cxx::__alloc_traits<_Tp_alloc_type> _Alloc_traits;
    public:
      typedef _Tp value_type;
      typedef typename _Base::pointer pointer;
      typedef typename _Alloc_traits::const_pointer const_pointer;
      typedef typename _Alloc_traits::reference reference;
      typedef typename _Alloc_traits::const_reference const_reference;
      typedef __gnu_cxx::__normal_iterator<pointer, vector> iterator;
      typedef __gnu_cxx::__normal_iterator<const_pointer, vector>
      const_iterator;
      typedef std::reverse_iterator<const_iterator> const_reverse_iterator;
      typedef std::reverse_iterator<iterator> reverse_iterator;
      typedef size_t size_type;
      typedef ptrdiff_t difference_type;
      typedef _Alloc allocator_type;
    protected:
      using _Base::_M_allocate;
      using _Base::_M_deallocate;
      using _Base::_M_impl;
      using _Base::_M_get_Tp_allocator;
    public:
      vector()
      noexcept(is_nothrow_default_constructible<_Alloc>::value)
      : _Base() { }
      explicit
      vector(const allocator_type& __a) noexcept
      : _Base(__a) { }
      explicit
      vector(size_type __n, const allocator_type& __a = allocator_type())
      : _Base(__n, __a)
      { _M_default_initialize(__n); }
      vector(size_type __n, const value_type& __value,
      const allocator_type& __a = allocator_type())
      : _Base(__n, __a)
      { _M_fill_initialize(__n, __value); }
      vector(const vector& __x)
      : _Base(__x.size(),
 _Alloc_traits::_S_select_on_copy(__x._M_get_Tp_allocator()))
      {
 this->_M_impl._M_finish =
   std::__uninitialized_copy_a(__x.begin(), __x.end(),
          this->_M_impl._M_start,
          _M_get_Tp_allocator());
      }
      vector(vector&& __x) noexcept
      : _Base(std::move(__x)) { }
      vector(const vector& __x, const allocator_type& __a)
      : _Base(__x.size(), __a)
      {
 this->_M_impl._M_finish =
   std::__uninitialized_copy_a(__x.begin(), __x.end(),
          this->_M_impl._M_start,
          _M_get_Tp_allocator());
      }
      vector(vector&& __rv, const allocator_type& __m)
      noexcept(_Alloc_traits::_S_always_equal())
      : _Base(std::move(__rv), __m)
      {
 if (__rv.get_allocator() != __m)
   {
     this->_M_impl._M_finish =
       std::__uninitialized_move_a(__rv.begin(), __rv.end(),
       this->_M_impl._M_start,
       _M_get_Tp_allocator());
     __rv.clear();
   }
      }
      vector(initializer_list<value_type> __l,
      const allocator_type& __a = allocator_type())
      : _Base(__a)
      {
 _M_range_initialize(__l.begin(), __l.end(),
       random_access_iterator_tag());
      }
      template<typename _InputIterator,
        typename = std::_RequireInputIter<_InputIterator>>
 vector(_InputIterator __first, _InputIterator __last,
        const allocator_type& __a = allocator_type())
 : _Base(__a)
 { _M_initialize_dispatch(__first, __last, __false_type()); }
      ~vector() noexcept
      {
 std::_Destroy(this->_M_impl._M_start, this->_M_impl._M_finish,
        _M_get_Tp_allocator());
 ;
      }
      vector&
      operator=(const vector& __x);
      vector&
      operator=(vector&& __x) noexcept(_Alloc_traits::_S_nothrow_move())
      {
 constexpr bool __move_storage =
   _Alloc_traits::_S_propagate_on_move_assign()
   || _Alloc_traits::_S_always_equal();
 _M_move_assign(std::move(__x), __bool_constant<__move_storage>());
 return *this;
      }
      vector&
      operator=(initializer_list<value_type> __l)
      {
 this->_M_assign_aux(__l.begin(), __l.end(),
       random_access_iterator_tag());
 return *this;
      }
      void
      assign(size_type __n, const value_type& __val)
      { _M_fill_assign(__n, __val); }
      template<typename _InputIterator,
        typename = std::_RequireInputIter<_InputIterator>>
 void
 assign(_InputIterator __first, _InputIterator __last)
 { _M_assign_dispatch(__first, __last, __false_type()); }
      void
      assign(initializer_list<value_type> __l)
      {
 this->_M_assign_aux(__l.begin(), __l.end(),
       random_access_iterator_tag());
      }
      using _Base::get_allocator;
      iterator
      begin() noexcept
      { return iterator(this->_M_impl._M_start); }
      const_iterator
      begin() const noexcept
      { return const_iterator(this->_M_impl._M_start); }
      iterator
      end() noexcept
      { return iterator(this->_M_impl._M_finish); }
      const_iterator
      end() const noexcept
      { return const_iterator(this->_M_impl._M_finish); }
      reverse_iterator
      rbegin() noexcept
      { return reverse_iterator(end()); }
      const_reverse_iterator
      rbegin() const noexcept
      { return const_reverse_iterator(end()); }
      reverse_iterator
      rend() noexcept
      { return reverse_iterator(begin()); }
      const_reverse_iterator
      rend() const noexcept
      { return const_reverse_iterator(begin()); }
      const_iterator
      cbegin() const noexcept
      { return const_iterator(this->_M_impl._M_start); }
      const_iterator
      cend() const noexcept
      { return const_iterator(this->_M_impl._M_finish); }
      const_reverse_iterator
      crbegin() const noexcept
      { return const_reverse_iterator(end()); }
      const_reverse_iterator
      crend() const noexcept
      { return const_reverse_iterator(begin()); }
      size_type
      size() const noexcept
      { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
      size_type
      max_size() const noexcept
      { return _Alloc_traits::max_size(_M_get_Tp_allocator()); }
      void
      resize(size_type __new_size)
      {
 if (__new_size > size())
   _M_default_append(__new_size - size());
 else if (__new_size < size())
   _M_erase_at_end(this->_M_impl._M_start + __new_size);
      }
      void
      resize(size_type __new_size, const value_type& __x)
      {
 if (__new_size > size())
   _M_fill_insert(end(), __new_size - size(), __x);
 else if (__new_size < size())
   _M_erase_at_end(this->_M_impl._M_start + __new_size);
      }
      void
      shrink_to_fit()
      { _M_shrink_to_fit(); }
      size_type
      capacity() const noexcept
      { return size_type(this->_M_impl._M_end_of_storage
    - this->_M_impl._M_start); }
      bool
      empty() const noexcept
      { return begin() == end(); }
      void
      reserve(size_type __n);
      reference
      operator[](size_type __n) noexcept
      {
 ;
 return *(this->_M_impl._M_start + __n);
      }
      const_reference
      operator[](size_type __n) const noexcept
      {
 ;
 return *(this->_M_impl._M_start + __n);
      }
    protected:
      void
      _M_range_check(size_type __n) const
      {
 if (__n >= this->size())
   __throw_out_of_range_fmt(("vector::_M_range_check: __n " "(which is %zu) >= this->size() " "(which is %zu)"),
       __n, this->size());
      }
    public:
      reference
      at(size_type __n)
      {
 _M_range_check(__n);
 return (*this)[__n];
      }
      const_reference
      at(size_type __n) const
      {
 _M_range_check(__n);
 return (*this)[__n];
      }
      reference
      front() noexcept
      {
 ;
 return *begin();
      }
      const_reference
      front() const noexcept
      {
 ;
 return *begin();
      }
      reference
      back() noexcept
      {
 ;
 return *(end() - 1);
      }
      const_reference
      back() const noexcept
      {
 ;
 return *(end() - 1);
      }
      _Tp*
      data() noexcept
      { return _M_data_ptr(this->_M_impl._M_start); }
      const _Tp*
      data() const noexcept
      { return _M_data_ptr(this->_M_impl._M_start); }
      void
      push_back(const value_type& __x)
      {
 if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
   {
     ;
     _Alloc_traits::construct(this->_M_impl, this->_M_impl._M_finish,
         __x);
     ++this->_M_impl._M_finish;
     ;
   }
 else
   _M_realloc_insert(end(), __x);
      }
      void
      push_back(value_type&& __x)
      { emplace_back(std::move(__x)); }
      template<typename... _Args>
 void
 emplace_back(_Args&&... __args);
      void
      pop_back() noexcept
      {
 ;
 --this->_M_impl._M_finish;
 _Alloc_traits::destroy(this->_M_impl, this->_M_impl._M_finish);
 ;
      }
      template<typename... _Args>
 iterator
 emplace(const_iterator __position, _Args&&... __args)
 { return _M_emplace_aux(__position, std::forward<_Args>(__args)...); }
      iterator
      insert(const_iterator __position, const value_type& __x);
      iterator
      insert(const_iterator __position, value_type&& __x)
      { return _M_insert_rval(__position, std::move(__x)); }
      iterator
      insert(const_iterator __position, initializer_list<value_type> __l)
      {
 auto __offset = __position - cbegin();
 _M_range_insert(begin() + __offset, __l.begin(), __l.end(),
   std::random_access_iterator_tag());
 return begin() + __offset;
      }
      iterator
      insert(const_iterator __position, size_type __n, const value_type& __x)
      {
 difference_type __offset = __position - cbegin();
 _M_fill_insert(begin() + __offset, __n, __x);
 return begin() + __offset;
      }
      template<typename _InputIterator,
        typename = std::_RequireInputIter<_InputIterator>>
 iterator
 insert(const_iterator __position, _InputIterator __first,
        _InputIterator __last)
 {
   difference_type __offset = __position - cbegin();
   _M_insert_dispatch(begin() + __offset,
        __first, __last, __false_type());
   return begin() + __offset;
 }
      iterator
      erase(const_iterator __position)
      { return _M_erase(begin() + (__position - cbegin())); }
      iterator
      erase(const_iterator __first, const_iterator __last)
      {
 const auto __beg = begin();
 const auto __cbeg = cbegin();
 return _M_erase(__beg + (__first - __cbeg), __beg + (__last - __cbeg));
      }
      void
      swap(vector& __x) noexcept
      {
 ;
 this->_M_impl._M_swap_data(__x._M_impl);
 _Alloc_traits::_S_on_swap(_M_get_Tp_allocator(),
      __x._M_get_Tp_allocator());
      }
      void
      clear() noexcept
      { _M_erase_at_end(this->_M_impl._M_start); }
    protected:
      template<typename _ForwardIterator>
 pointer
 _M_allocate_and_copy(size_type __n,
        _ForwardIterator __first, _ForwardIterator __last)
 {
   pointer __result = this->_M_allocate(__n);
   try
     {
       std::__uninitialized_copy_a(__first, __last, __result,
       _M_get_Tp_allocator());
       return __result;
     }
   catch(...)
     {
       _M_deallocate(__result, __n);
       throw;
     }
 }
      template<typename _Integer>
 void
 _M_initialize_dispatch(_Integer __n, _Integer __value, __true_type)
 {
   this->_M_impl._M_start = _M_allocate(static_cast<size_type>(__n));
   this->_M_impl._M_end_of_storage =
     this->_M_impl._M_start + static_cast<size_type>(__n);
   _M_fill_initialize(static_cast<size_type>(__n), __value);
 }
      template<typename _InputIterator>
 void
 _M_initialize_dispatch(_InputIterator __first, _InputIterator __last,
          __false_type)
 {
   typedef typename std::iterator_traits<_InputIterator>::
     iterator_category _IterCategory;
   _M_range_initialize(__first, __last, _IterCategory());
 }
      template<typename _InputIterator>
 void
 _M_range_initialize(_InputIterator __first,
       _InputIterator __last, std::input_iterator_tag)
 {
   for (; __first != __last; ++__first)
     emplace_back(*__first);
 }
      template<typename _ForwardIterator>
 void
 _M_range_initialize(_ForwardIterator __first,
       _ForwardIterator __last, std::forward_iterator_tag)
 {
   const size_type __n = std::distance(__first, __last);
   this->_M_impl._M_start = this->_M_allocate(__n);
   this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
   this->_M_impl._M_finish =
     std::__uninitialized_copy_a(__first, __last,
     this->_M_impl._M_start,
     _M_get_Tp_allocator());
 }
      void
      _M_fill_initialize(size_type __n, const value_type& __value)
      {
 this->_M_impl._M_finish =
   std::__uninitialized_fill_n_a(this->_M_impl._M_start, __n, __value,
     _M_get_Tp_allocator());
      }
      void
      _M_default_initialize(size_type __n)
      {
 this->_M_impl._M_finish =
   std::__uninitialized_default_n_a(this->_M_impl._M_start, __n,
        _M_get_Tp_allocator());
      }
      template<typename _Integer>
 void
 _M_assign_dispatch(_Integer __n, _Integer __val, __true_type)
 { _M_fill_assign(__n, __val); }
      template<typename _InputIterator>
 void
 _M_assign_dispatch(_InputIterator __first, _InputIterator __last,
      __false_type)
 { _M_assign_aux(__first, __last, std::__iterator_category(__first)); }
      template<typename _InputIterator>
 void
 _M_assign_aux(_InputIterator __first, _InputIterator __last,
        std::input_iterator_tag);
      template<typename _ForwardIterator>
 void
 _M_assign_aux(_ForwardIterator __first, _ForwardIterator __last,
        std::forward_iterator_tag);
      void
      _M_fill_assign(size_type __n, const value_type& __val);
      template<typename _Integer>
 void
 _M_insert_dispatch(iterator __pos, _Integer __n, _Integer __val,
      __true_type)
 { _M_fill_insert(__pos, __n, __val); }
      template<typename _InputIterator>
 void
 _M_insert_dispatch(iterator __pos, _InputIterator __first,
      _InputIterator __last, __false_type)
 {
   _M_range_insert(__pos, __first, __last,
     std::__iterator_category(__first));
 }
      template<typename _InputIterator>
 void
 _M_range_insert(iterator __pos, _InputIterator __first,
   _InputIterator __last, std::input_iterator_tag);
      template<typename _ForwardIterator>
 void
 _M_range_insert(iterator __pos, _ForwardIterator __first,
   _ForwardIterator __last, std::forward_iterator_tag);
      void
      _M_fill_insert(iterator __pos, size_type __n, const value_type& __x);
      void
      _M_default_append(size_type __n);
      bool
      _M_shrink_to_fit();
      struct _Temporary_value
      {
 template<typename... _Args>
   explicit
   _Temporary_value(vector* __vec, _Args&&... __args) : _M_this(__vec)
   {
     _Alloc_traits::construct(_M_this->_M_impl, _M_ptr(),
         std::forward<_Args>(__args)...);
   }
 ~_Temporary_value()
 { _Alloc_traits::destroy(_M_this->_M_impl, _M_ptr()); }
 value_type&
 _M_val() { return *reinterpret_cast<_Tp*>(&__buf); }
      private:
 pointer
 _M_ptr() { return pointer_traits<pointer>::pointer_to(_M_val()); }
 vector* _M_this;
 typename aligned_storage<sizeof(_Tp), alignof(_Tp)>::type __buf;
      };
      template<typename _Arg>
 void
 _M_insert_aux(iterator __position, _Arg&& __arg);
      template<typename... _Args>
 void
 _M_realloc_insert(iterator __position, _Args&&... __args);
      iterator
      _M_insert_rval(const_iterator __position, value_type&& __v);
      template<typename... _Args>
 iterator
 _M_emplace_aux(const_iterator __position, _Args&&... __args);
      iterator
      _M_emplace_aux(const_iterator __position, value_type&& __v)
      { return _M_insert_rval(__position, std::move(__v)); }
      size_type
      _M_check_len(size_type __n, const char* __s) const
      {
 if (max_size() - size() < __n)
   __throw_length_error((__s));
 const size_type __len = size() + std::max(size(), __n);
 return (__len < size() || __len > max_size()) ? max_size() : __len;
      }
      void
      _M_erase_at_end(pointer __pos) noexcept
      {
 if (size_type __n = this->_M_impl._M_finish - __pos)
   {
     std::_Destroy(__pos, this->_M_impl._M_finish,
     _M_get_Tp_allocator());
     this->_M_impl._M_finish = __pos;
     ;
   }
      }
      iterator
      _M_erase(iterator __position);
      iterator
      _M_erase(iterator __first, iterator __last);
    private:
      void
      _M_move_assign(vector&& __x, std::true_type) noexcept
      {
 vector __tmp(get_allocator());
 this->_M_impl._M_swap_data(__tmp._M_impl);
 this->_M_impl._M_swap_data(__x._M_impl);
 std::__alloc_on_move(_M_get_Tp_allocator(), __x._M_get_Tp_allocator());
      }
      void
      _M_move_assign(vector&& __x, std::false_type)
      {
 if (__x._M_get_Tp_allocator() == this->_M_get_Tp_allocator())
   _M_move_assign(std::move(__x), std::true_type());
 else
   {
     this->assign(std::__make_move_if_noexcept_iterator(__x.begin()),
    std::__make_move_if_noexcept_iterator(__x.end()));
     __x.clear();
   }
      }
      template<typename _Up>
 _Up*
 _M_data_ptr(_Up* __ptr) const noexcept
 { return __ptr; }
      template<typename _Ptr>
 typename std::pointer_traits<_Ptr>::element_type*
 _M_data_ptr(_Ptr __ptr) const
 { return empty() ? nullptr : std::__to_address(__ptr); }
    };
  template<typename _Tp, typename _Alloc>
    inline bool
    operator==(const vector<_Tp, _Alloc>& __x, const vector<_Tp, _Alloc>& __y)
    { return (__x.size() == __y.size()
       && std::equal(__x.begin(), __x.end(), __y.begin())); }
  template<typename _Tp, typename _Alloc>
    inline bool
    operator<(const vector<_Tp, _Alloc>& __x, const vector<_Tp, _Alloc>& __y)
    { return std::lexicographical_compare(__x.begin(), __x.end(),
       __y.begin(), __y.end()); }
  template<typename _Tp, typename _Alloc>
    inline bool
    operator!=(const vector<_Tp, _Alloc>& __x, const vector<_Tp, _Alloc>& __y)
    { return !(__x == __y); }
  template<typename _Tp, typename _Alloc>
    inline bool
    operator>(const vector<_Tp, _Alloc>& __x, const vector<_Tp, _Alloc>& __y)
    { return __y < __x; }
  template<typename _Tp, typename _Alloc>
    inline bool
    operator<=(const vector<_Tp, _Alloc>& __x, const vector<_Tp, _Alloc>& __y)
    { return !(__y < __x); }
  template<typename _Tp, typename _Alloc>
    inline bool
    operator>=(const vector<_Tp, _Alloc>& __x, const vector<_Tp, _Alloc>& __y)
    { return !(__x < __y); }
  template<typename _Tp, typename _Alloc>
    inline void
    swap(vector<_Tp, _Alloc>& __x, vector<_Tp, _Alloc>& __y)
    noexcept(noexcept(__x.swap(__y)))
    { __x.swap(__y); }


}
namespace std
{


  typedef unsigned long _Bit_type;
  enum { _S_word_bit = int(8 * sizeof(_Bit_type)) };
  struct _Bit_reference
  {
    _Bit_type * _M_p;
    _Bit_type _M_mask;
    _Bit_reference(_Bit_type * __x, _Bit_type __y)
    : _M_p(__x), _M_mask(__y) { }
    _Bit_reference() noexcept : _M_p(0), _M_mask(0) { }
    operator bool() const noexcept
    { return !!(*_M_p & _M_mask); }
    _Bit_reference&
    operator=(bool __x) noexcept
    {
      if (__x)
 *_M_p |= _M_mask;
      else
 *_M_p &= ~_M_mask;
      return *this;
    }
    _Bit_reference&
    operator=(const _Bit_reference& __x) noexcept
    { return *this = bool(__x); }
    bool
    operator==(const _Bit_reference& __x) const
    { return bool(*this) == bool(__x); }
    bool
    operator<(const _Bit_reference& __x) const
    { return !bool(*this) && bool(__x); }
    void
    flip() noexcept
    { *_M_p ^= _M_mask; }
  };
  inline void
  swap(_Bit_reference __x, _Bit_reference __y) noexcept
  {
    bool __tmp = __x;
    __x = __y;
    __y = __tmp;
  }
  inline void
  swap(_Bit_reference __x, bool& __y) noexcept
  {
    bool __tmp = __x;
    __x = __y;
    __y = __tmp;
  }
  inline void
  swap(bool& __x, _Bit_reference __y) noexcept
  {
    bool __tmp = __x;
    __x = __y;
    __y = __tmp;
  }
  struct _Bit_iterator_base
  : public std::iterator<std::random_access_iterator_tag, bool>
  {
    _Bit_type * _M_p;
    unsigned int _M_offset;
    _Bit_iterator_base(_Bit_type * __x, unsigned int __y)
    : _M_p(__x), _M_offset(__y) { }
    void
    _M_bump_up()
    {
      if (_M_offset++ == int(_S_word_bit) - 1)
 {
   _M_offset = 0;
   ++_M_p;
 }
    }
    void
    _M_bump_down()
    {
      if (_M_offset-- == 0)
 {
   _M_offset = int(_S_word_bit) - 1;
   --_M_p;
 }
    }
    void
    _M_incr(ptrdiff_t __i)
    {
      difference_type __n = __i + _M_offset;
      _M_p += __n / int(_S_word_bit);
      __n = __n % int(_S_word_bit);
      if (__n < 0)
 {
   __n += int(_S_word_bit);
   --_M_p;
 }
      _M_offset = static_cast<unsigned int>(__n);
    }
    bool
    operator==(const _Bit_iterator_base& __i) const
    { return _M_p == __i._M_p && _M_offset == __i._M_offset; }
    bool
    operator<(const _Bit_iterator_base& __i) const
    {
      return _M_p < __i._M_p
     || (_M_p == __i._M_p && _M_offset < __i._M_offset);
    }
    bool
    operator!=(const _Bit_iterator_base& __i) const
    { return !(*this == __i); }
    bool
    operator>(const _Bit_iterator_base& __i) const
    { return __i < *this; }
    bool
    operator<=(const _Bit_iterator_base& __i) const
    { return !(__i < *this); }
    bool
    operator>=(const _Bit_iterator_base& __i) const
    { return !(*this < __i); }
  };
  inline ptrdiff_t
  operator-(const _Bit_iterator_base& __x, const _Bit_iterator_base& __y)
  {
    return (int(_S_word_bit) * (__x._M_p - __y._M_p)
     + __x._M_offset - __y._M_offset);
  }
  struct _Bit_iterator : public _Bit_iterator_base
  {
    typedef _Bit_reference reference;
    typedef _Bit_reference* pointer;
    typedef _Bit_iterator iterator;
    _Bit_iterator() : _Bit_iterator_base(0, 0) { }
    _Bit_iterator(_Bit_type * __x, unsigned int __y)
    : _Bit_iterator_base(__x, __y) { }
    iterator
    _M_const_cast() const
    { return *this; }
    reference
    operator*() const
    { return reference(_M_p, 1UL << _M_offset); }
    iterator&
    operator++()
    {
      _M_bump_up();
      return *this;
    }
    iterator
    operator++(int)
    {
      iterator __tmp = *this;
      _M_bump_up();
      return __tmp;
    }
    iterator&
    operator--()
    {
      _M_bump_down();
      return *this;
    }
    iterator
    operator--(int)
    {
      iterator __tmp = *this;
      _M_bump_down();
      return __tmp;
    }
    iterator&
    operator+=(difference_type __i)
    {
      _M_incr(__i);
      return *this;
    }
    iterator&
    operator-=(difference_type __i)
    {
      *this += -__i;
      return *this;
    }
    iterator
    operator+(difference_type __i) const
    {
      iterator __tmp = *this;
      return __tmp += __i;
    }
    iterator
    operator-(difference_type __i) const
    {
      iterator __tmp = *this;
      return __tmp -= __i;
    }
    reference
    operator[](difference_type __i) const
    { return *(*this + __i); }
  };
  inline _Bit_iterator
  operator+(ptrdiff_t __n, const _Bit_iterator& __x)
  { return __x + __n; }
  struct _Bit_const_iterator : public _Bit_iterator_base
  {
    typedef bool reference;
    typedef bool const_reference;
    typedef const bool* pointer;
    typedef _Bit_const_iterator const_iterator;
    _Bit_const_iterator() : _Bit_iterator_base(0, 0) { }
    _Bit_const_iterator(_Bit_type * __x, unsigned int __y)
    : _Bit_iterator_base(__x, __y) { }
    _Bit_const_iterator(const _Bit_iterator& __x)
    : _Bit_iterator_base(__x._M_p, __x._M_offset) { }
    _Bit_iterator
    _M_const_cast() const
    { return _Bit_iterator(_M_p, _M_offset); }
    const_reference
    operator*() const
    { return _Bit_reference(_M_p, 1UL << _M_offset); }
    const_iterator&
    operator++()
    {
      _M_bump_up();
      return *this;
    }
    const_iterator
    operator++(int)
    {
      const_iterator __tmp = *this;
      _M_bump_up();
      return __tmp;
    }
    const_iterator&
    operator--()
    {
      _M_bump_down();
      return *this;
    }
    const_iterator
    operator--(int)
    {
      const_iterator __tmp = *this;
      _M_bump_down();
      return __tmp;
    }
    const_iterator&
    operator+=(difference_type __i)
    {
      _M_incr(__i);
      return *this;
    }
    const_iterator&
    operator-=(difference_type __i)
    {
      *this += -__i;
      return *this;
    }
    const_iterator
    operator+(difference_type __i) const
    {
      const_iterator __tmp = *this;
      return __tmp += __i;
    }
    const_iterator
    operator-(difference_type __i) const
    {
      const_iterator __tmp = *this;
      return __tmp -= __i;
    }
    const_reference
    operator[](difference_type __i) const
    { return *(*this + __i); }
  };
  inline _Bit_const_iterator
  operator+(ptrdiff_t __n, const _Bit_const_iterator& __x)
  { return __x + __n; }
  inline void
  __fill_bvector(_Bit_type * __v,
   unsigned int __first, unsigned int __last, bool __x)
  {
    const _Bit_type __fmask = ~0ul << __first;
    const _Bit_type __lmask = ~0ul >> (_S_word_bit - __last);
    const _Bit_type __mask = __fmask & __lmask;
    if (__x)
      *__v |= __mask;
    else
      *__v &= ~__mask;
  }
  inline void
  fill(_Bit_iterator __first, _Bit_iterator __last, const bool& __x)
  {
    if (__first._M_p != __last._M_p)
      {
 _Bit_type* __first_p = __first._M_p;
 if (__first._M_offset != 0)
   __fill_bvector(__first_p++, __first._M_offset, _S_word_bit, __x);
 __builtin_memset(__first_p, __x ? ~0 : 0,
    (__last._M_p - __first_p) * sizeof(_Bit_type));
 if (__last._M_offset != 0)
   __fill_bvector(__last._M_p, 0, __last._M_offset, __x);
      }
    else if (__first._M_offset != __last._M_offset)
      __fill_bvector(__first._M_p, __first._M_offset, __last._M_offset, __x);
  }
  template<typename _Alloc>
    struct _Bvector_base
    {
      typedef typename __gnu_cxx::__alloc_traits<_Alloc>::template
        rebind<_Bit_type>::other _Bit_alloc_type;
      typedef typename __gnu_cxx::__alloc_traits<_Bit_alloc_type>
 _Bit_alloc_traits;
      typedef typename _Bit_alloc_traits::pointer _Bit_pointer;
      struct _Bvector_impl_data
      {
 _Bit_iterator _M_start;
 _Bit_iterator _M_finish;
 _Bit_pointer _M_end_of_storage;
 _Bvector_impl_data() noexcept
 : _M_start(), _M_finish(), _M_end_of_storage()
 { }
 _Bvector_impl_data(_Bvector_impl_data&& __x) noexcept
 : _M_start(__x._M_start), _M_finish(__x._M_finish)
 , _M_end_of_storage(__x._M_end_of_storage)
 { __x._M_reset(); }
 void
 _M_move_data(_Bvector_impl_data&& __x) noexcept
 {
   this->_M_start = __x._M_start;
   this->_M_finish = __x._M_finish;
   this->_M_end_of_storage = __x._M_end_of_storage;
   __x._M_reset();
 }
 void
 _M_reset() noexcept
 {
   _M_start = _M_finish = _Bit_iterator();
   _M_end_of_storage = _Bit_pointer();
 }
      };
      struct _Bvector_impl
 : public _Bit_alloc_type, public _Bvector_impl_data
 {
 public:
   _Bvector_impl()
     noexcept(noexcept(_Bit_alloc_type()))
   : _Bit_alloc_type()
   { }
   _Bvector_impl(const _Bit_alloc_type& __a) noexcept
   : _Bit_alloc_type(__a)
   { }
 _Bvector_impl(_Bvector_impl&&) = default;
 _Bit_type*
 _M_end_addr() const noexcept
 {
   if (this->_M_end_of_storage)
     return std::__addressof(this->_M_end_of_storage[-1]) + 1;
   return 0;
 }
      };
    public:
      typedef _Alloc allocator_type;
      _Bit_alloc_type&
      _M_get_Bit_allocator() noexcept
      { return this->_M_impl; }
      const _Bit_alloc_type&
      _M_get_Bit_allocator() const noexcept
      { return this->_M_impl; }
      allocator_type
      get_allocator() const noexcept
      { return allocator_type(_M_get_Bit_allocator()); }
      _Bvector_base() = default;
      _Bvector_base(const allocator_type& __a)
      : _M_impl(__a) { }
      _Bvector_base(_Bvector_base&&) = default;
      ~_Bvector_base()
      { this->_M_deallocate(); }
    protected:
      _Bvector_impl _M_impl;
      _Bit_pointer
      _M_allocate(size_t __n)
      { return _Bit_alloc_traits::allocate(_M_impl, _S_nword(__n)); }
      void
      _M_deallocate()
      {
 if (_M_impl._M_start._M_p)
   {
     const size_t __n = _M_impl._M_end_addr() - _M_impl._M_start._M_p;
     _Bit_alloc_traits::deallocate(_M_impl,
       _M_impl._M_end_of_storage - __n,
       __n);
     _M_impl._M_reset();
   }
      }
      void
      _M_move_data(_Bvector_base&& __x) noexcept
      { _M_impl._M_move_data(std::move(__x._M_impl)); }
      static size_t
      _S_nword(size_t __n)
      { return (__n + int(_S_word_bit) - 1) / int(_S_word_bit); }
    };


}
namespace std
{


  template<typename _Alloc>
    class vector<bool, _Alloc> : protected _Bvector_base<_Alloc>
    {
      typedef _Bvector_base<_Alloc> _Base;
      typedef typename _Base::_Bit_pointer _Bit_pointer;
      typedef typename _Base::_Bit_alloc_traits _Bit_alloc_traits;
      friend struct std::hash<vector>;
    public:
      typedef bool value_type;
      typedef size_t size_type;
      typedef ptrdiff_t difference_type;
      typedef _Bit_reference reference;
      typedef bool const_reference;
      typedef _Bit_reference* pointer;
      typedef const bool* const_pointer;
      typedef _Bit_iterator iterator;
      typedef _Bit_const_iterator const_iterator;
      typedef std::reverse_iterator<const_iterator> const_reverse_iterator;
      typedef std::reverse_iterator<iterator> reverse_iterator;
      typedef _Alloc allocator_type;
      allocator_type
      get_allocator() const
      { return _Base::get_allocator(); }
    protected:
      using _Base::_M_allocate;
      using _Base::_M_deallocate;
      using _Base::_S_nword;
      using _Base::_M_get_Bit_allocator;
    public:
      vector() = default;
      explicit
      vector(const allocator_type& __a)
      : _Base(__a) { }
      explicit
      vector(size_type __n, const allocator_type& __a = allocator_type())
      : vector(__n, false, __a)
      { }
      vector(size_type __n, const bool& __value,
      const allocator_type& __a = allocator_type())
      : _Base(__a)
      {
 _M_initialize(__n);
 _M_initialize_value(__value);
      }
      vector(const vector& __x)
      : _Base(_Bit_alloc_traits::_S_select_on_copy(__x._M_get_Bit_allocator()))
      {
 _M_initialize(__x.size());
 _M_copy_aligned(__x.begin(), __x.end(), this->_M_impl._M_start);
      }
      vector(vector&&) = default;
      vector(vector&& __x, const allocator_type& __a)
      noexcept(_Bit_alloc_traits::_S_always_equal())
      : _Base(__a)
      {
 if (__x.get_allocator() == __a)
   this->_M_move_data(std::move(__x));
 else
   {
     _M_initialize(__x.size());
     _M_copy_aligned(__x.begin(), __x.end(), begin());
     __x.clear();
   }
      }
      vector(const vector& __x, const allocator_type& __a)
      : _Base(__a)
      {
 _M_initialize(__x.size());
 _M_copy_aligned(__x.begin(), __x.end(), this->_M_impl._M_start);
      }
      vector(initializer_list<bool> __l,
      const allocator_type& __a = allocator_type())
      : _Base(__a)
      {
 _M_initialize_range(__l.begin(), __l.end(),
       random_access_iterator_tag());
      }
      template<typename _InputIterator,
        typename = std::_RequireInputIter<_InputIterator>>
 vector(_InputIterator __first, _InputIterator __last,
        const allocator_type& __a = allocator_type())
 : _Base(__a)
 { _M_initialize_dispatch(__first, __last, __false_type()); }
      ~vector() noexcept { }
      vector&
      operator=(const vector& __x)
      {
 if (&__x == this)
   return *this;
 if (_Bit_alloc_traits::_S_propagate_on_copy_assign())
   {
     if (this->_M_get_Bit_allocator() != __x._M_get_Bit_allocator())
       {
  this->_M_deallocate();
  std::__alloc_on_copy(_M_get_Bit_allocator(),
         __x._M_get_Bit_allocator());
  _M_initialize(__x.size());
       }
     else
       std::__alloc_on_copy(_M_get_Bit_allocator(),
       __x._M_get_Bit_allocator());
   }
 if (__x.size() > capacity())
   {
     this->_M_deallocate();
     _M_initialize(__x.size());
   }
 this->_M_impl._M_finish = _M_copy_aligned(__x.begin(), __x.end(),
        begin());
 return *this;
      }
      vector&
      operator=(vector&& __x) noexcept(_Bit_alloc_traits::_S_nothrow_move())
      {
 if (_Bit_alloc_traits::_S_propagate_on_move_assign()
     || this->_M_get_Bit_allocator() == __x._M_get_Bit_allocator())
   {
     this->_M_deallocate();
     this->_M_move_data(std::move(__x));
     std::__alloc_on_move(_M_get_Bit_allocator(),
     __x._M_get_Bit_allocator());
   }
 else
   {
     if (__x.size() > capacity())
       {
  this->_M_deallocate();
  _M_initialize(__x.size());
       }
     this->_M_impl._M_finish = _M_copy_aligned(__x.begin(), __x.end(),
            begin());
     __x.clear();
   }
 return *this;
      }
      vector&
      operator=(initializer_list<bool> __l)
      {
 this->assign (__l.begin(), __l.end());
 return *this;
      }
      void
      assign(size_type __n, const bool& __x)
      { _M_fill_assign(__n, __x); }
      template<typename _InputIterator,
        typename = std::_RequireInputIter<_InputIterator>>
 void
 assign(_InputIterator __first, _InputIterator __last)
 { _M_assign_aux(__first, __last, std::__iterator_category(__first)); }
      void
      assign(initializer_list<bool> __l)
      { _M_assign_aux(__l.begin(), __l.end(), random_access_iterator_tag()); }
      iterator
      begin() noexcept
      { return this->_M_impl._M_start; }
      const_iterator
      begin() const noexcept
      { return this->_M_impl._M_start; }
      iterator
      end() noexcept
      { return this->_M_impl._M_finish; }
      const_iterator
      end() const noexcept
      { return this->_M_impl._M_finish; }
      reverse_iterator
      rbegin() noexcept
      { return reverse_iterator(end()); }
      const_reverse_iterator
      rbegin() const noexcept
      { return const_reverse_iterator(end()); }
      reverse_iterator
      rend() noexcept
      { return reverse_iterator(begin()); }
      const_reverse_iterator
      rend() const noexcept
      { return const_reverse_iterator(begin()); }
      const_iterator
      cbegin() const noexcept
      { return this->_M_impl._M_start; }
      const_iterator
      cend() const noexcept
      { return this->_M_impl._M_finish; }
      const_reverse_iterator
      crbegin() const noexcept
      { return const_reverse_iterator(end()); }
      const_reverse_iterator
      crend() const noexcept
      { return const_reverse_iterator(begin()); }
      size_type
      size() const noexcept
      { return size_type(end() - begin()); }
      size_type
      max_size() const noexcept
      {
 const size_type __isize =
   __gnu_cxx::__numeric_traits<difference_type>::__max
   - int(_S_word_bit) + 1;
 const size_type __asize
   = _Bit_alloc_traits::max_size(_M_get_Bit_allocator());
 return (__asize <= __isize / int(_S_word_bit)
  ? __asize * int(_S_word_bit) : __isize);
      }
      size_type
      capacity() const noexcept
      { return size_type(const_iterator(this->_M_impl._M_end_addr(), 0)
    - begin()); }
      bool
      empty() const noexcept
      { return begin() == end(); }
      reference
      operator[](size_type __n)
      {
 return *iterator(this->_M_impl._M_start._M_p
    + __n / int(_S_word_bit), __n % int(_S_word_bit));
      }
      const_reference
      operator[](size_type __n) const
      {
 return *const_iterator(this->_M_impl._M_start._M_p
        + __n / int(_S_word_bit), __n % int(_S_word_bit));
      }
    protected:
      void
      _M_range_check(size_type __n) const
      {
 if (__n >= this->size())
   __throw_out_of_range_fmt(("vector<bool>::_M_range_check: __n " "(which is %zu) >= this->size() " "(which is %zu)"),
       __n, this->size());
      }
    public:
      reference
      at(size_type __n)
      { _M_range_check(__n); return (*this)[__n]; }
      const_reference
      at(size_type __n) const
      { _M_range_check(__n); return (*this)[__n]; }
      void
      reserve(size_type __n)
      {
 if (__n > max_size())
   __throw_length_error(("vector::reserve"));
 if (capacity() < __n)
   _M_reallocate(__n);
      }
      reference
      front()
      { return *begin(); }
      const_reference
      front() const
      { return *begin(); }
      reference
      back()
      { return *(end() - 1); }
      const_reference
      back() const
      { return *(end() - 1); }
      void
      data() noexcept { }
      void
      push_back(bool __x)
      {
 if (this->_M_impl._M_finish._M_p != this->_M_impl._M_end_addr())
   *this->_M_impl._M_finish++ = __x;
 else
   _M_insert_aux(end(), __x);
      }
      void
      swap(vector& __x) noexcept
      {
 std::swap(this->_M_impl._M_start, __x._M_impl._M_start);
 std::swap(this->_M_impl._M_finish, __x._M_impl._M_finish);
 std::swap(this->_M_impl._M_end_of_storage,
    __x._M_impl._M_end_of_storage);
 _Bit_alloc_traits::_S_on_swap(_M_get_Bit_allocator(),
          __x._M_get_Bit_allocator());
      }
      static void
      swap(reference __x, reference __y) noexcept
      {
 bool __tmp = __x;
 __x = __y;
 __y = __tmp;
      }
      iterator
      insert(const_iterator __position, const bool& __x = bool())
      {
 const difference_type __n = __position - begin();
 if (this->_M_impl._M_finish._M_p != this->_M_impl._M_end_addr()
     && __position == end())
   *this->_M_impl._M_finish++ = __x;
 else
   _M_insert_aux(__position._M_const_cast(), __x);
 return begin() + __n;
      }
      template<typename _InputIterator,
        typename = std::_RequireInputIter<_InputIterator>>
 iterator
 insert(const_iterator __position,
        _InputIterator __first, _InputIterator __last)
 {
   difference_type __offset = __position - cbegin();
   _M_insert_dispatch(__position._M_const_cast(),
        __first, __last, __false_type());
   return begin() + __offset;
 }
      iterator
      insert(const_iterator __position, size_type __n, const bool& __x)
      {
 difference_type __offset = __position - cbegin();
 _M_fill_insert(__position._M_const_cast(), __n, __x);
 return begin() + __offset;
      }
      iterator
      insert(const_iterator __p, initializer_list<bool> __l)
      { return this->insert(__p, __l.begin(), __l.end()); }
      void
      pop_back()
      { --this->_M_impl._M_finish; }
      iterator
      erase(const_iterator __position)
      { return _M_erase(__position._M_const_cast()); }
      iterator
      erase(const_iterator __first, const_iterator __last)
      { return _M_erase(__first._M_const_cast(), __last._M_const_cast()); }
      void
      resize(size_type __new_size, bool __x = bool())
      {
 if (__new_size < size())
   _M_erase_at_end(begin() + difference_type(__new_size));
 else
   insert(end(), __new_size - size(), __x);
      }
      void
      shrink_to_fit()
      { _M_shrink_to_fit(); }
      void
      flip() noexcept
      {
 _Bit_type * const __end = this->_M_impl._M_end_addr();
 for (_Bit_type * __p = this->_M_impl._M_start._M_p; __p != __end; ++__p)
   *__p = ~*__p;
      }
      void
      clear() noexcept
      { _M_erase_at_end(begin()); }
      template<typename... _Args>
 void
 emplace_back(_Args&&... __args)
 {
   push_back(bool(__args...));
 }
      template<typename... _Args>
 iterator
 emplace(const_iterator __pos, _Args&&... __args)
 { return insert(__pos, bool(__args...)); }
    protected:
      iterator
      _M_copy_aligned(const_iterator __first, const_iterator __last,
        iterator __result)
      {
 _Bit_type* __q = std::copy(__first._M_p, __last._M_p, __result._M_p);
 return std::copy(const_iterator(__last._M_p, 0), __last,
    iterator(__q, 0));
      }
      void
      _M_initialize(size_type __n)
      {
 if (__n)
   {
     _Bit_pointer __q = this->_M_allocate(__n);
     this->_M_impl._M_end_of_storage = __q + _S_nword(__n);
     this->_M_impl._M_start = iterator(std::__addressof(*__q), 0);
   }
 else
   {
     this->_M_impl._M_end_of_storage = _Bit_pointer();
     this->_M_impl._M_start = iterator(0, 0);
   }
 this->_M_impl._M_finish = this->_M_impl._M_start + difference_type(__n);
      }
      void
      _M_initialize_value(bool __x)
      {
 if (_Bit_type* __p = this->_M_impl._M_start._M_p)
   __builtin_memset(__p, __x ? ~0 : 0,
      (this->_M_impl._M_end_addr() - __p)
      * sizeof(_Bit_type));
      }
      void
      _M_reallocate(size_type __n);
      bool
      _M_shrink_to_fit();
      template<typename _Integer>
 void
 _M_initialize_dispatch(_Integer __n, _Integer __x, __true_type)
 {
   _M_initialize(static_cast<size_type>(__n));
   _M_initialize_value(__x);
 }
      template<typename _InputIterator>
 void
 _M_initialize_dispatch(_InputIterator __first, _InputIterator __last,
          __false_type)
 { _M_initialize_range(__first, __last,
         std::__iterator_category(__first)); }
      template<typename _InputIterator>
 void
 _M_initialize_range(_InputIterator __first, _InputIterator __last,
       std::input_iterator_tag)
 {
   for (; __first != __last; ++__first)
     push_back(*__first);
 }
      template<typename _ForwardIterator>
 void
 _M_initialize_range(_ForwardIterator __first, _ForwardIterator __last,
       std::forward_iterator_tag)
 {
   const size_type __n = std::distance(__first, __last);
   _M_initialize(__n);
   std::copy(__first, __last, this->_M_impl._M_start);
 }
      void
      _M_fill_assign(size_t __n, bool __x)
      {
 if (__n > size())
   {
     _M_initialize_value(__x);
     insert(end(), __n - size(), __x);
   }
 else
   {
     _M_erase_at_end(begin() + __n);
     _M_initialize_value(__x);
   }
      }
      template<typename _InputIterator>
 void
 _M_assign_aux(_InputIterator __first, _InputIterator __last,
        std::input_iterator_tag)
 {
   iterator __cur = begin();
   for (; __first != __last && __cur != end(); ++__cur, ++__first)
     *__cur = *__first;
   if (__first == __last)
     _M_erase_at_end(__cur);
   else
     insert(end(), __first, __last);
 }
      template<typename _ForwardIterator>
 void
 _M_assign_aux(_ForwardIterator __first, _ForwardIterator __last,
        std::forward_iterator_tag)
 {
   const size_type __len = std::distance(__first, __last);
   if (__len < size())
     _M_erase_at_end(std::copy(__first, __last, begin()));
   else
     {
       _ForwardIterator __mid = __first;
       std::advance(__mid, size());
       std::copy(__first, __mid, begin());
       insert(end(), __mid, __last);
     }
 }
      template<typename _Integer>
 void
 _M_insert_dispatch(iterator __pos, _Integer __n, _Integer __x,
      __true_type)
 { _M_fill_insert(__pos, __n, __x); }
      template<typename _InputIterator>
 void
 _M_insert_dispatch(iterator __pos,
      _InputIterator __first, _InputIterator __last,
      __false_type)
 { _M_insert_range(__pos, __first, __last,
     std::__iterator_category(__first)); }
      void
      _M_fill_insert(iterator __position, size_type __n, bool __x);
      template<typename _InputIterator>
 void
 _M_insert_range(iterator __pos, _InputIterator __first,
   _InputIterator __last, std::input_iterator_tag)
 {
   for (; __first != __last; ++__first)
     {
       __pos = insert(__pos, *__first);
       ++__pos;
     }
 }
      template<typename _ForwardIterator>
 void
 _M_insert_range(iterator __position, _ForwardIterator __first,
   _ForwardIterator __last, std::forward_iterator_tag);
      void
      _M_insert_aux(iterator __position, bool __x);
      size_type
      _M_check_len(size_type __n, const char* __s) const
      {
 if (max_size() - size() < __n)
   __throw_length_error((__s));
 const size_type __len = size() + std::max(size(), __n);
 return (__len < size() || __len > max_size()) ? max_size() : __len;
      }
      void
      _M_erase_at_end(iterator __pos)
      { this->_M_impl._M_finish = __pos; }
      iterator
      _M_erase(iterator __pos);
      iterator
      _M_erase(iterator __first, iterator __last);
  };


}
namespace std
{

  template<typename _Alloc>
    struct hash<std::vector<bool, _Alloc>>
    : public __hash_base<size_t, std::vector<bool, _Alloc>>
    {
      size_t
      operator()(const std::vector<bool, _Alloc>&) const noexcept;
    };

}
namespace std
{


  template<typename _Tp, typename _Alloc>
    void
    vector<_Tp, _Alloc>::
    reserve(size_type __n)
    {
      if (__n > this->max_size())
 __throw_length_error(("vector::reserve"));
      if (this->capacity() < __n)
 {
   const size_type __old_size = size();
   pointer __tmp = _M_allocate_and_copy(__n,
     std::__make_move_if_noexcept_iterator(this->_M_impl._M_start),
     std::__make_move_if_noexcept_iterator(this->_M_impl._M_finish));
   ;
   std::_Destroy(this->_M_impl._M_start, this->_M_impl._M_finish,
   _M_get_Tp_allocator());
   _M_deallocate(this->_M_impl._M_start,
   this->_M_impl._M_end_of_storage
   - this->_M_impl._M_start);
   this->_M_impl._M_start = __tmp;
   this->_M_impl._M_finish = __tmp + __old_size;
   this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
 }
    }
  template<typename _Tp, typename _Alloc>
    template<typename... _Args>
      void
      vector<_Tp, _Alloc>::
      emplace_back(_Args&&... __args)
      {
 if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
   {
     ;
     _Alloc_traits::construct(this->_M_impl, this->_M_impl._M_finish,
         std::forward<_Args>(__args)...);
     ++this->_M_impl._M_finish;
     ;
   }
 else
   _M_realloc_insert(end(), std::forward<_Args>(__args)...);
      }
  template<typename _Tp, typename _Alloc>
    typename vector<_Tp, _Alloc>::iterator
    vector<_Tp, _Alloc>::
    insert(const_iterator __position, const value_type& __x)
    {
      const size_type __n = __position - begin();
      if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
 if (__position == end())
   {
     ;
     _Alloc_traits::construct(this->_M_impl, this->_M_impl._M_finish,
         __x);
     ++this->_M_impl._M_finish;
     ;
   }
 else
   {
     const auto __pos = begin() + (__position - cbegin());
     _Temporary_value __x_copy(this, __x);
     _M_insert_aux(__pos, std::move(__x_copy._M_val()));
   }
      else
 _M_realloc_insert(begin() + (__position - cbegin()), __x);
      return iterator(this->_M_impl._M_start + __n);
    }
  template<typename _Tp, typename _Alloc>
    typename vector<_Tp, _Alloc>::iterator
    vector<_Tp, _Alloc>::
    _M_erase(iterator __position)
    {
      if (__position + 1 != end())
 std::move(__position + 1, end(), __position);
      --this->_M_impl._M_finish;
      _Alloc_traits::destroy(this->_M_impl, this->_M_impl._M_finish);
      ;
      return __position;
    }
  template<typename _Tp, typename _Alloc>
    typename vector<_Tp, _Alloc>::iterator
    vector<_Tp, _Alloc>::
    _M_erase(iterator __first, iterator __last)
    {
      if (__first != __last)
 {
   if (__last != end())
     std::move(__last, end(), __first);
   _M_erase_at_end(__first.base() + (end() - __last));
 }
      return __first;
    }
  template<typename _Tp, typename _Alloc>
    vector<_Tp, _Alloc>&
    vector<_Tp, _Alloc>::
    operator=(const vector<_Tp, _Alloc>& __x)
    {
      if (&__x != this)
 {
   ;
   if (_Alloc_traits::_S_propagate_on_copy_assign())
     {
       if (!_Alloc_traits::_S_always_equal()
           && _M_get_Tp_allocator() != __x._M_get_Tp_allocator())
         {
    this->clear();
    _M_deallocate(this->_M_impl._M_start,
    this->_M_impl._M_end_of_storage
    - this->_M_impl._M_start);
    this->_M_impl._M_start = nullptr;
    this->_M_impl._M_finish = nullptr;
    this->_M_impl._M_end_of_storage = nullptr;
  }
       std::__alloc_on_copy(_M_get_Tp_allocator(),
       __x._M_get_Tp_allocator());
     }
   const size_type __xlen = __x.size();
   if (__xlen > capacity())
     {
       pointer __tmp = _M_allocate_and_copy(__xlen, __x.begin(),
         __x.end());
       std::_Destroy(this->_M_impl._M_start, this->_M_impl._M_finish,
       _M_get_Tp_allocator());
       _M_deallocate(this->_M_impl._M_start,
       this->_M_impl._M_end_of_storage
       - this->_M_impl._M_start);
       this->_M_impl._M_start = __tmp;
       this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __xlen;
     }
   else if (size() >= __xlen)
     {
       std::_Destroy(std::copy(__x.begin(), __x.end(), begin()),
       end(), _M_get_Tp_allocator());
     }
   else
     {
       std::copy(__x._M_impl._M_start, __x._M_impl._M_start + size(),
   this->_M_impl._M_start);
       std::__uninitialized_copy_a(__x._M_impl._M_start + size(),
       __x._M_impl._M_finish,
       this->_M_impl._M_finish,
       _M_get_Tp_allocator());
     }
   this->_M_impl._M_finish = this->_M_impl._M_start + __xlen;
 }
      return *this;
    }
  template<typename _Tp, typename _Alloc>
    void
    vector<_Tp, _Alloc>::
    _M_fill_assign(size_t __n, const value_type& __val)
    {
      if (__n > capacity())
 {
   vector __tmp(__n, __val, _M_get_Tp_allocator());
   __tmp._M_impl._M_swap_data(this->_M_impl);
 }
      else if (__n > size())
 {
   std::fill(begin(), end(), __val);
   const size_type __add = __n - size();
   ;
   this->_M_impl._M_finish =
     std::__uninitialized_fill_n_a(this->_M_impl._M_finish,
       __add, __val, _M_get_Tp_allocator());
   ;
 }
      else
        _M_erase_at_end(std::fill_n(this->_M_impl._M_start, __n, __val));
    }
  template<typename _Tp, typename _Alloc>
    template<typename _InputIterator>
      void
      vector<_Tp, _Alloc>::
      _M_assign_aux(_InputIterator __first, _InputIterator __last,
      std::input_iterator_tag)
      {
 pointer __cur(this->_M_impl._M_start);
 for (; __first != __last && __cur != this->_M_impl._M_finish;
      ++__cur, ++__first)
   *__cur = *__first;
 if (__first == __last)
   _M_erase_at_end(__cur);
 else
   _M_range_insert(end(), __first, __last,
     std::__iterator_category(__first));
      }
  template<typename _Tp, typename _Alloc>
    template<typename _ForwardIterator>
      void
      vector<_Tp, _Alloc>::
      _M_assign_aux(_ForwardIterator __first, _ForwardIterator __last,
      std::forward_iterator_tag)
      {
 const size_type __len = std::distance(__first, __last);
 if (__len > capacity())
   {
     pointer __tmp(_M_allocate_and_copy(__len, __first, __last));
     ;
     std::_Destroy(this->_M_impl._M_start, this->_M_impl._M_finish,
     _M_get_Tp_allocator());
     _M_deallocate(this->_M_impl._M_start,
     this->_M_impl._M_end_of_storage
     - this->_M_impl._M_start);
     this->_M_impl._M_start = __tmp;
     this->_M_impl._M_finish = this->_M_impl._M_start + __len;
     this->_M_impl._M_end_of_storage = this->_M_impl._M_finish;
   }
 else if (size() >= __len)
   _M_erase_at_end(std::copy(__first, __last, this->_M_impl._M_start));
 else
   {
     _ForwardIterator __mid = __first;
     std::advance(__mid, size());
     std::copy(__first, __mid, this->_M_impl._M_start);
     const size_type __attribute__((__unused__)) __n = __len - size();
     ;
     this->_M_impl._M_finish =
       std::__uninitialized_copy_a(__mid, __last,
       this->_M_impl._M_finish,
       _M_get_Tp_allocator());
     ;
   }
      }
  template<typename _Tp, typename _Alloc>
    auto
    vector<_Tp, _Alloc>::
    _M_insert_rval(const_iterator __position, value_type&& __v) -> iterator
    {
      const auto __n = __position - cbegin();
      if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
 if (__position == cend())
   {
     ;
     _Alloc_traits::construct(this->_M_impl, this->_M_impl._M_finish,
         std::move(__v));
     ++this->_M_impl._M_finish;
     ;
   }
 else
   _M_insert_aux(begin() + __n, std::move(__v));
      else
 _M_realloc_insert(begin() + __n, std::move(__v));
      return iterator(this->_M_impl._M_start + __n);
    }
  template<typename _Tp, typename _Alloc>
    template<typename... _Args>
      auto
      vector<_Tp, _Alloc>::
      _M_emplace_aux(const_iterator __position, _Args&&... __args)
      -> iterator
      {
 const auto __n = __position - cbegin();
 if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
   if (__position == cend())
     {
       ;
       _Alloc_traits::construct(this->_M_impl, this->_M_impl._M_finish,
           std::forward<_Args>(__args)...);
       ++this->_M_impl._M_finish;
       ;
     }
   else
     {
       _Temporary_value __tmp(this, std::forward<_Args>(__args)...);
       _M_insert_aux(begin() + __n, std::move(__tmp._M_val()));
     }
 else
   _M_realloc_insert(begin() + __n, std::forward<_Args>(__args)...);
 return iterator(this->_M_impl._M_start + __n);
      }
  template<typename _Tp, typename _Alloc>
    template<typename _Arg>
      void
      vector<_Tp, _Alloc>::
      _M_insert_aux(iterator __position, _Arg&& __arg)
    {
      ;
      _Alloc_traits::construct(this->_M_impl, this->_M_impl._M_finish,
          std::move(*(this->_M_impl._M_finish - 1)));
      ++this->_M_impl._M_finish;
      ;
      std::move_backward(__position.base(), this->_M_impl._M_finish - 2, this->_M_impl._M_finish - 1);
      *__position = std::forward<_Arg>(__arg);
    }
  template<typename _Tp, typename _Alloc>
    template<typename... _Args>
      void
      vector<_Tp, _Alloc>::
      _M_realloc_insert(iterator __position, _Args&&... __args)
    {
      const size_type __len =
 _M_check_len(size_type(1), "vector::_M_realloc_insert");
      pointer __old_start = this->_M_impl._M_start;
      pointer __old_finish = this->_M_impl._M_finish;
      const size_type __elems_before = __position - begin();
      pointer __new_start(this->_M_allocate(__len));
      pointer __new_finish(__new_start);
      try
 {
   _Alloc_traits::construct(this->_M_impl,
       __new_start + __elems_before,
       std::forward<_Args>(__args)...);
   __new_finish = pointer();
   __new_finish
     = std::__uninitialized_move_if_noexcept_a
     (__old_start, __position.base(),
      __new_start, _M_get_Tp_allocator());
   ++__new_finish;
   __new_finish
     = std::__uninitialized_move_if_noexcept_a
     (__position.base(), __old_finish,
      __new_finish, _M_get_Tp_allocator());
 }
      catch(...)
 {
   if (!__new_finish)
     _Alloc_traits::destroy(this->_M_impl,
       __new_start + __elems_before);
   else
     std::_Destroy(__new_start, __new_finish, _M_get_Tp_allocator());
   _M_deallocate(__new_start, __len);
   throw;
 }
      ;
      std::_Destroy(__old_start, __old_finish, _M_get_Tp_allocator());
      _M_deallocate(__old_start,
      this->_M_impl._M_end_of_storage - __old_start);
      this->_M_impl._M_start = __new_start;
      this->_M_impl._M_finish = __new_finish;
      this->_M_impl._M_end_of_storage = __new_start + __len;
    }
  template<typename _Tp, typename _Alloc>
    void
    vector<_Tp, _Alloc>::
    _M_fill_insert(iterator __position, size_type __n, const value_type& __x)
    {
      if (__n != 0)
 {
   if (size_type(this->_M_impl._M_end_of_storage
   - this->_M_impl._M_finish) >= __n)
     {
       _Temporary_value __tmp(this, __x);
       value_type& __x_copy = __tmp._M_val();
       const size_type __elems_after = end() - __position;
       pointer __old_finish(this->_M_impl._M_finish);
       if (__elems_after > __n)
  {
    ;
    std::__uninitialized_move_a(this->_M_impl._M_finish - __n,
           this->_M_impl._M_finish,
           this->_M_impl._M_finish,
           _M_get_Tp_allocator());
    this->_M_impl._M_finish += __n;
    ;
    std::move_backward(__position.base(), __old_finish - __n, __old_finish);
    std::fill(__position.base(), __position.base() + __n,
       __x_copy);
  }
       else
  {
    ;
    this->_M_impl._M_finish =
      std::__uninitialized_fill_n_a(this->_M_impl._M_finish,
        __n - __elems_after,
        __x_copy,
        _M_get_Tp_allocator());
    ;
    std::__uninitialized_move_a(__position.base(), __old_finish,
           this->_M_impl._M_finish,
           _M_get_Tp_allocator());
    this->_M_impl._M_finish += __elems_after;
    ;
    std::fill(__position.base(), __old_finish, __x_copy);
  }
     }
   else
     {
       const size_type __len =
  _M_check_len(__n, "vector::_M_fill_insert");
       const size_type __elems_before = __position - begin();
       pointer __new_start(this->_M_allocate(__len));
       pointer __new_finish(__new_start);
       try
  {
    std::__uninitialized_fill_n_a(__new_start + __elems_before,
      __n, __x,
      _M_get_Tp_allocator());
    __new_finish = pointer();
    __new_finish
      = std::__uninitialized_move_if_noexcept_a
      (this->_M_impl._M_start, __position.base(),
       __new_start, _M_get_Tp_allocator());
    __new_finish += __n;
    __new_finish
      = std::__uninitialized_move_if_noexcept_a
      (__position.base(), this->_M_impl._M_finish,
       __new_finish, _M_get_Tp_allocator());
  }
       catch(...)
  {
    if (!__new_finish)
      std::_Destroy(__new_start + __elems_before,
      __new_start + __elems_before + __n,
      _M_get_Tp_allocator());
    else
      std::_Destroy(__new_start, __new_finish,
      _M_get_Tp_allocator());
    _M_deallocate(__new_start, __len);
    throw;
  }
       ;
       std::_Destroy(this->_M_impl._M_start, this->_M_impl._M_finish,
       _M_get_Tp_allocator());
       _M_deallocate(this->_M_impl._M_start,
       this->_M_impl._M_end_of_storage
       - this->_M_impl._M_start);
       this->_M_impl._M_start = __new_start;
       this->_M_impl._M_finish = __new_finish;
       this->_M_impl._M_end_of_storage = __new_start + __len;
     }
 }
    }
  template<typename _Tp, typename _Alloc>
    void
    vector<_Tp, _Alloc>::
    _M_default_append(size_type __n)
    {
      if (__n != 0)
 {
   size_type __size = size();
   size_type __navail = size_type(this->_M_impl._M_end_of_storage
      - this->_M_impl._M_finish);
   if (__size > max_size() || __navail > max_size() - __size)
     __builtin_unreachable();
   if (__navail >= __n)
     {
       ;
       this->_M_impl._M_finish =
  std::__uninitialized_default_n_a(this->_M_impl._M_finish,
       __n, _M_get_Tp_allocator());
       ;
     }
   else
     {
       const size_type __len =
  _M_check_len(__n, "vector::_M_default_append");
       const size_type __old_size = __size;
       pointer __new_start(this->_M_allocate(__len));
       pointer __new_finish(__new_start);
       try
  {
    __new_finish
      = std::__uninitialized_move_if_noexcept_a
      (this->_M_impl._M_start, this->_M_impl._M_finish,
       __new_start, _M_get_Tp_allocator());
    __new_finish =
      std::__uninitialized_default_n_a(__new_finish, __n,
           _M_get_Tp_allocator());
  }
       catch(...)
  {
    std::_Destroy(__new_start, __new_finish,
    _M_get_Tp_allocator());
    _M_deallocate(__new_start, __len);
    throw;
  }
       ;
       std::_Destroy(this->_M_impl._M_start, this->_M_impl._M_finish,
       _M_get_Tp_allocator());
       _M_deallocate(this->_M_impl._M_start,
       this->_M_impl._M_end_of_storage
       - this->_M_impl._M_start);
       this->_M_impl._M_start = __new_start;
       this->_M_impl._M_finish = __new_finish;
       this->_M_impl._M_end_of_storage = __new_start + __len;
     }
 }
    }
  template<typename _Tp, typename _Alloc>
    bool
    vector<_Tp, _Alloc>::
    _M_shrink_to_fit()
    {
      if (capacity() == size())
 return false;
      ;
      return std::__shrink_to_fit_aux<vector>::_S_do_it(*this);
    }
  template<typename _Tp, typename _Alloc>
    template<typename _InputIterator>
      void
      vector<_Tp, _Alloc>::
      _M_range_insert(iterator __pos, _InputIterator __first,
        _InputIterator __last, std::input_iterator_tag)
      {
 if (__pos == end())
   {
     for (; __first != __last; ++__first)
       insert(end(), *__first);
   }
 else if (__first != __last)
   {
     vector __tmp(__first, __last, _M_get_Tp_allocator());
     insert(__pos,
     std::make_move_iterator(__tmp.begin()),
     std::make_move_iterator(__tmp.end()));
   }
      }
  template<typename _Tp, typename _Alloc>
    template<typename _ForwardIterator>
      void
      vector<_Tp, _Alloc>::
      _M_range_insert(iterator __position, _ForwardIterator __first,
        _ForwardIterator __last, std::forward_iterator_tag)
      {
 if (__first != __last)
   {
     const size_type __n = std::distance(__first, __last);
     if (size_type(this->_M_impl._M_end_of_storage
     - this->_M_impl._M_finish) >= __n)
       {
  const size_type __elems_after = end() - __position;
  pointer __old_finish(this->_M_impl._M_finish);
  if (__elems_after > __n)
    {
      ;
      std::__uninitialized_move_a(this->_M_impl._M_finish - __n,
      this->_M_impl._M_finish,
      this->_M_impl._M_finish,
      _M_get_Tp_allocator());
      this->_M_impl._M_finish += __n;
      ;
      std::move_backward(__position.base(), __old_finish - __n, __old_finish);
      std::copy(__first, __last, __position);
    }
  else
    {
      _ForwardIterator __mid = __first;
      std::advance(__mid, __elems_after);
      ;
      std::__uninitialized_copy_a(__mid, __last,
      this->_M_impl._M_finish,
      _M_get_Tp_allocator());
      this->_M_impl._M_finish += __n - __elems_after;
      ;
      std::__uninitialized_move_a(__position.base(),
      __old_finish,
      this->_M_impl._M_finish,
      _M_get_Tp_allocator());
      this->_M_impl._M_finish += __elems_after;
      ;
      std::copy(__first, __mid, __position);
    }
       }
     else
       {
  const size_type __len =
    _M_check_len(__n, "vector::_M_range_insert");
  pointer __new_start(this->_M_allocate(__len));
  pointer __new_finish(__new_start);
  try
    {
      __new_finish
        = std::__uninitialized_move_if_noexcept_a
        (this->_M_impl._M_start, __position.base(),
         __new_start, _M_get_Tp_allocator());
      __new_finish
        = std::__uninitialized_copy_a(__first, __last,
          __new_finish,
          _M_get_Tp_allocator());
      __new_finish
        = std::__uninitialized_move_if_noexcept_a
        (__position.base(), this->_M_impl._M_finish,
         __new_finish, _M_get_Tp_allocator());
    }
  catch(...)
    {
      std::_Destroy(__new_start, __new_finish,
      _M_get_Tp_allocator());
      _M_deallocate(__new_start, __len);
      throw;
    }
  ;
  std::_Destroy(this->_M_impl._M_start, this->_M_impl._M_finish,
         _M_get_Tp_allocator());
  _M_deallocate(this->_M_impl._M_start,
         this->_M_impl._M_end_of_storage
         - this->_M_impl._M_start);
  this->_M_impl._M_start = __new_start;
  this->_M_impl._M_finish = __new_finish;
  this->_M_impl._M_end_of_storage = __new_start + __len;
       }
   }
      }
  template<typename _Alloc>
    void
    vector<bool, _Alloc>::
    _M_reallocate(size_type __n)
    {
      _Bit_pointer __q = this->_M_allocate(__n);
      iterator __start(std::__addressof(*__q), 0);
      iterator __finish(_M_copy_aligned(begin(), end(), __start));
      this->_M_deallocate();
      this->_M_impl._M_start = __start;
      this->_M_impl._M_finish = __finish;
      this->_M_impl._M_end_of_storage = __q + _S_nword(__n);
    }
  template<typename _Alloc>
    void
    vector<bool, _Alloc>::
    _M_fill_insert(iterator __position, size_type __n, bool __x)
    {
      if (__n == 0)
 return;
      if (capacity() - size() >= __n)
 {
   std::copy_backward(__position, end(),
        this->_M_impl._M_finish + difference_type(__n));
   std::fill(__position, __position + difference_type(__n), __x);
   this->_M_impl._M_finish += difference_type(__n);
 }
      else
 {
   const size_type __len =
     _M_check_len(__n, "vector<bool>::_M_fill_insert");
   _Bit_pointer __q = this->_M_allocate(__len);
   iterator __start(std::__addressof(*__q), 0);
   iterator __i = _M_copy_aligned(begin(), __position, __start);
   std::fill(__i, __i + difference_type(__n), __x);
   iterator __finish = std::copy(__position, end(),
     __i + difference_type(__n));
   this->_M_deallocate();
   this->_M_impl._M_end_of_storage = __q + _S_nword(__len);
   this->_M_impl._M_start = __start;
   this->_M_impl._M_finish = __finish;
 }
    }
  template<typename _Alloc>
    template<typename _ForwardIterator>
      void
      vector<bool, _Alloc>::
      _M_insert_range(iterator __position, _ForwardIterator __first,
        _ForwardIterator __last, std::forward_iterator_tag)
      {
 if (__first != __last)
   {
     size_type __n = std::distance(__first, __last);
     if (capacity() - size() >= __n)
       {
  std::copy_backward(__position, end(),
       this->_M_impl._M_finish
       + difference_type(__n));
  std::copy(__first, __last, __position);
  this->_M_impl._M_finish += difference_type(__n);
       }
     else
       {
  const size_type __len =
    _M_check_len(__n, "vector<bool>::_M_insert_range");
  _Bit_pointer __q = this->_M_allocate(__len);
  iterator __start(std::__addressof(*__q), 0);
  iterator __i = _M_copy_aligned(begin(), __position, __start);
  __i = std::copy(__first, __last, __i);
  iterator __finish = std::copy(__position, end(), __i);
  this->_M_deallocate();
  this->_M_impl._M_end_of_storage = __q + _S_nword(__len);
  this->_M_impl._M_start = __start;
  this->_M_impl._M_finish = __finish;
       }
   }
      }
  template<typename _Alloc>
    void
    vector<bool, _Alloc>::
    _M_insert_aux(iterator __position, bool __x)
    {
      if (this->_M_impl._M_finish._M_p != this->_M_impl._M_end_addr())
 {
   std::copy_backward(__position, this->_M_impl._M_finish,
        this->_M_impl._M_finish + 1);
   *__position = __x;
   ++this->_M_impl._M_finish;
 }
      else
 {
   const size_type __len =
     _M_check_len(size_type(1), "vector<bool>::_M_insert_aux");
   _Bit_pointer __q = this->_M_allocate(__len);
   iterator __start(std::__addressof(*__q), 0);
   iterator __i = _M_copy_aligned(begin(), __position, __start);
   *__i++ = __x;
   iterator __finish = std::copy(__position, end(), __i);
   this->_M_deallocate();
   this->_M_impl._M_end_of_storage = __q + _S_nword(__len);
   this->_M_impl._M_start = __start;
   this->_M_impl._M_finish = __finish;
 }
    }
  template<typename _Alloc>
    typename vector<bool, _Alloc>::iterator
    vector<bool, _Alloc>::
    _M_erase(iterator __position)
    {
      if (__position + 1 != end())
        std::copy(__position + 1, end(), __position);
      --this->_M_impl._M_finish;
      return __position;
    }
  template<typename _Alloc>
    typename vector<bool, _Alloc>::iterator
    vector<bool, _Alloc>::
    _M_erase(iterator __first, iterator __last)
    {
      if (__first != __last)
 _M_erase_at_end(std::copy(__last, end(), __first));
      return __first;
    }
  template<typename _Alloc>
    bool
    vector<bool, _Alloc>::
    _M_shrink_to_fit()
    {
      if (capacity() - size() < int(_S_word_bit))
 return false;
      try
 {
   _M_reallocate(size());
   return true;
 }
      catch(...)
 { return false; }
    }


}
namespace std
{

  template<typename _Alloc>
    size_t
    hash<std::vector<bool, _Alloc>>::
    operator()(const std::vector<bool, _Alloc>& __b) const noexcept
    {
      size_t __hash = 0;
      using std::_S_word_bit;
      using std::_Bit_type;
      const size_t __words = __b.size() / _S_word_bit;
      if (__words)
 {
   const size_t __clength = __words * sizeof(_Bit_type);
   __hash = std::_Hash_impl::hash(__b._M_impl._M_start._M_p, __clength);
 }
      const size_t __extrabits = __b.size() % _S_word_bit;
      if (__extrabits)
 {
   _Bit_type __hiword = *__b._M_impl._M_finish._M_p;
   __hiword &= ~((~static_cast<_Bit_type>(0)) << __extrabits);
   const size_t __clength
     = (__extrabits + 8 - 1) / 8;
   if (__words)
     __hash = std::_Hash_impl::hash(&__hiword, __clength, __hash);
   else
     __hash = std::_Hash_impl::hash(&__hiword, __clength);
 }
      return __hash;
    }

}