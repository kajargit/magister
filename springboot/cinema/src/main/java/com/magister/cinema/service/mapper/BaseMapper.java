package com.magister.cinema.service.mapper;

import org.modelmapper.AbstractConverter;
import org.modelmapper.Converter;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.Base64;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class BaseMapper {

    @Autowired
    private ModelMapper modelMapper;

    @PostConstruct
    public void init(){

        //byte[] base64
        Converter<byte[], String> bytearrayToBase64 = new AbstractConverter<>() {
            @Override
            protected String convert(byte[] source) {
                if(source == null){
                    return null;
                }
                return Base64.getEncoder().encodeToString(source);
            }
        };
        modelMapper.createTypeMap(byte[].class, String.class);
        modelMapper.addConverter(bytearrayToBase64);
    }

    public <T> T map(Object source, Class<T> targetClass) {
        return modelMapper.map(source, targetClass);
    }

    public <S, T> List<T> mapList(List<S> source, Class<T> targetClass) {
        return source
                .stream()
                .map(element -> modelMapper.map(element, targetClass))
                .collect(Collectors.toList());
    }
}
