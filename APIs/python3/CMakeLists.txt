
FIND_PACKAGE(PythonLibs 3)

INCLUDE_DIRECTORIES(${PYTHON_INCLUDE_DIRS})

SET_PROPERTY(SOURCE freeling_pythonAPI.i PROPERTY CPLUSPLUS ON)

SET(CMAKE_SWIG_FLAGS "-py3")
if(APPLE)
  SWIG_ADD_LIBRARY(pyfreeling TYPE MODULE LANGUAGE python SOURCES freeling_pythonAPI.i)
else()
  SWIG_ADD_LIBRARY(pyfreeling TYPE SHARED LANGUAGE python SOURCES freeling_pythonAPI.i)
endif()

SWIG_LINK_LIBRARIES(pyfreeling freeling ${PYTHON_LIBRARIES} ${Boost_LIBRARIES})

install(TARGETS _pyfreeling DESTINATION share/freeling/APIs/python3)
install(PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/pyfreeling.py ${CMAKE_CURRENT_SOURCE_DIR}/sample.py
        DESTINATION share/freeling/APIs/python3)

