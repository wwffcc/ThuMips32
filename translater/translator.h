#ifndef TRANSLATOR_H_
#define TRANSLATOR_H_

#include <string>
#include <map>

class Translator
{
public:
	Translator();
	~Translator(){}	
	void parse(char* filename);
private:	
	std::map<std::string,unsigned int> op_table;
};

#endif
