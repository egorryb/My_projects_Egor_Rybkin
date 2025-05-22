package jsonwork

import (
	"encoding/json"
	"fmt"
	"os"
)

type Photo struct {
	Image         string
	Filter        Filter_type
	Output_format string
	Quality       int
}
type Filter_type struct {
	Mode      string
	intensity float64
}

func LoadFromJSON(path string, data *Photo) error {
	in, err := os.Open(path)
	if err != nil {
		return err
	}
	decoder := json.NewDecoder(in)
	defer in.Close()
	err = decoder.Decode(data)
	if err != nil {
		return err
	}
	return nil
}

func (p *Photo) LookatPhoto() {
	fmt.Println(p)
}
