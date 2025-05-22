package strg

import (
	"FirstHTTP/jsonwork"
	"errors"
)

type RamStorage struct {
	data map[string]jsonwork.Photo
}

func (s *RamStorage) Get(key string) (*jsonwork.Photo, error) {
	value, ok := s.data[key]
	if !ok {
		return nil, errors.New("No such key")
	}
	return &value, nil
}

func (s *RamStorage) Put(key string, value jsonwork.Photo) error {
	s.data[key] = value
	return nil
}

func (s *RamStorage) Post(key string, value jsonwork.Photo) error {
	if _, exists := s.data[key]; exists {
		return errors.New("key already exists")
	}
	s.data[key] = value
	return nil
}
func NewRamStorage() *RamStorage {
	t := &RamStorage{data: make(map[string]jsonwork.Photo)}
	return t
}
