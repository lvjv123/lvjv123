package com.crud.test;
import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.api.ShellCallback;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.exception.InvalidConfigurationException;
import org.mybatis.generator.exception.XMLParserException;
import org.mybatis.generator.internal.DefaultShellCallback;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MBGtest {

    public static void main(String[] args) throws IOException, XMLParserException, InvalidConfigurationException, SQLException, InterruptedException, SQLException {
       //配置文件的路径
        File f = new File("mbg.xml");

        List<String> warnings = new ArrayList<String>();
        ConfigurationParser parser = new ConfigurationParser(warnings);

        Configuration configuration = parser.parseConfiguration(f);

        boolean overwrite = true;
        ShellCallback shellCallback = new DefaultShellCallback(overwrite);
        MyBatisGenerator generator = new MyBatisGenerator(configuration, shellCallback, warnings);

        generator.generate(null);

        System.out.println("OK!");
    }
}
