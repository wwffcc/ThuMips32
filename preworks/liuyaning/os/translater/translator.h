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
	void disas(char* filename);
private:	
	std::map<std::string,unsigned int> op_table;
	std::map<unsigned int,std::string> disas_table;
};

#endif
